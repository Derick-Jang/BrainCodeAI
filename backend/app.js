// Import required modules
const express = require('express');
const OpenAI = require('openai');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
require('dotenv').config();
const { query } = require('./database/database');
const { checkJwt } = require('./auth/auth');

// Create an Express application instance - this is our web server
const app = express();
// Set the port number - use environment variable PORT or default to 5000
const PORT = process.env.PORT || 4000;

// Initialize OpenAI client with our API key from environment variables
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// Enable CORS Middleware
app.use(cors({
  origin: ['http://localhost:3000', 'http://127.0.0.1:3000'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
// Parse JSON request bodies - converts JSON data from requests into JavaScript objects
app.use(express.json({ limit: '10mb' }));

// Create rate limiter - prevents abuse by limiting requests per IP address
const limiter = rateLimit({
  windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS) || 15 * 60 * 1000,
  max: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS) || 5,
  message: {
    error: 'Too many requests, please try again later.'
  }
});

// Apply rate limiting to all API routes
//app.use('/api/', limiter);

// Function to create a prompt for OpenAI based on problem and user code
function createFeedbackPrompt(problemTitle, userCode, language) {
  // Return a formatted string that will be sent to OpenAI
  return `You are an experienced software engineer conducting a technical interview. 

PROBLEM: ${problemTitle}
LANGUAGE: ${language}

CANDIDATE'S SOLUTION:
\`\`\`
${userCode}
\`\`\`

Provide constructive feedback on this solution. Focus on:
1. Correctness - Does the solution solve the problem?
2. Time/Space Complexity - What's the complexity and can it be improved?
3. Code Quality - Is the code clean and readable?
4. Edge Cases - Are important edge cases handled?

Keep your response concise (under 200 words) and encouraging. If the solution has issues, provide specific guidance on how to improve it.

Format your response in a friendly, interview-like manner.`;
}

// Health check endpoint - used to verify server is running
app.get('/api/health', (req, res) => {
  // Send back server status and timestamp
  res.json({ 
    status: 'OK', // Server is healthy
    timestamp: new Date().toISOString(), // Current time
    environment: process.env.NODE_ENV // Current environment (development/production)
  });
});

// Get problem endpoint - returns the current problem data
app.get('/api/problem', async (req, res) => {
  try {
    const result = await query('SELECT * FROM problems ORDER BY RANDOM() LIMIT 1', []);
    const problem = result.rows[0]; // Returns the row as a javascript object
    
    // Send back success response with problem data
    res.json({
      success: true,
      problemData: problem
    });
  } catch (error) {
    // If something goes wrong, log the error
    console.error('Error fetching problem:', error);
    
    // Send back error response
    res.status(500).json({
      success: false, // Request failed
      error: 'Failed to fetch problem' // Error message
    });
  }
});

// Submit code endpoint - processes user code and returns AI feedback
app.post('/api/submit', async (req, res) => {
  try {
    // Extract code and problemTitle from the request body
    const { code, problemTitle, language } = req.body;

    // ============================================================================
    // INPUT VALIDATION SHOULD BE DONE IN THE FRONTEND
    // ============================================================================
    
    // Check if code exists and is a string
    if (!code || typeof code !== 'string') {
      return res.status(400).json({
        success: false,
        error: 'Code is required and must be a string'
      });
    }

    // Check if code is not empty after removing whitespace
    if (code.trim().length === 0) {
      return res.status(400).json({
        success: false,
        error: 'Code cannot be empty'
      });
    }

    // Check if code is not too long (prevent abuse)
    if (code.length > 5000) {
      return res.status(400).json({
        success: false,
        error: 'Code is too long (max 5000 characters)'
      });
    }

    // ============================================================================
    // AI FEEDBACK GENERATION
    // ============================================================================
    
    // Create a prompt for OpenAI using our helper function FIX LATER USING CORRECT PARAMETERS
    const prompt = createFeedbackPrompt(problemTitle, code, language);

    // Call OpenAI API to get feedback on the user's code
    const completion = await openai.chat.completions.create({
      model: "gpt-3.5-turbo", // Use GPT-3.5 Turbo model
      messages: [
        {
          role: "system", // System message sets the AI's behavior
          content: "You are a helpful and encouraging technical interviewer providing code review feedback."
        },
        {
          role: "user", // User message contains our prompt
          content: prompt
        }
      ],
      max_tokens: 300, // Limit response to 300 tokens (about 200 words)
      temperature: 0.3, // Low temperature for consistent, focused responses
    });

    // Extract the feedback text from OpenAI's response
    const feedback = completion.choices[0]?.message?.content;

    // Check if we actually got feedback
    if (!feedback) {
      throw new Error('No feedback received from AI');
    }
    // Send back successful response with feedback
    res.json({
      success: true,
      data: {
        feedback: feedback.trim(), // Remove extra whitespace
        submittedAt: new Date().toISOString(), // When the code was submitted
      }
    });

  } catch (error) {
    // ============================================================================
    // ERROR HANDLING
    // ============================================================================
    
    // Log the error for debugging
    console.error('Error in submit endpoint:', error);
    
    // Handle specific OpenAI errors
    if (error.code === 'insufficient_quota') {
      return res.status(429).json({
        success: false,
        error: 'AI service temporarily unavailable. Please try again later.'
      });
    }

    if (error.code === 'rate_limit_exceeded') {
      return res.status(429).json({
        success: false,
        error: 'Too many requests to AI service. Please wait a moment and try again.'
      });
    }

    // Handle any other errors
    res.status(500).json({
      success: false,
      error: 'Failed to process submission. Please try again.'
    });
  }
});

// Helper function to ensure user exists in database
async function ensureUserExists(auth0Id, email, name) {
  try {
    // Check if user already exists
    const existingUser = await query(
      'SELECT id FROM users WHERE auth0_id = $1',
      [auth0Id]
    );

    if (existingUser.rows.length > 0) {
      return existingUser.rows[0].id;
    }

    // Create new user if doesn't exist
    const newUser = await query(
      'INSERT INTO users (auth0_id, email, name) VALUES ($1, $2, $3) RETURNING id',
      [auth0Id, email, name || 'User']
    );

    return newUser.rows[0].id;
  } catch (error) {
    console.error('Error ensuring user exists:', error);
    throw error;
  }
}

// Protected endpoint for user registration/ensure user exists
app.post('/api/register', checkJwt, async (req, res) => {
  try {
    const { auth0Id, name, email } = req.body;

    if (!auth0Id || !name || !email) {
      return res.status(400).json({
        success: false,
        error: 'Missing user information'
      });
    }

    // Ensure user exists in database (create if first time)
    const userId = await ensureUserExists(auth0Id, email, name);
    
    res.json({
      success: true,
      message: 'User registered successfully',
      userId: userId
    });
  } catch (error) {
    console.error('Error registering user:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to register user'
    });
  }
});

// Protected endpoint for marking problem as complete
app.post('/api/complete', checkJwt, async (req, res) => {
  try {
    const { problemId , category, auth0Id } = req.body;

    if (!problemId || !category || !auth0Id) {
      return res.status(400).json({
        success: false,
        error: 'Missing problem information'
      });
    }

    const userResult = await query(
      'SELECT id FROM users WHERE auth0_id = $1',
      [auth0Id]
    );

    if (userResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'User not found'
      });
    }

    const userId = userResult.rows[0].id;

    const result = await query(
      `INSERT INTO user_completions (user_id, problem_id, category, attempts)
       VALUES ($1, $2, $3, 1)
       ON CONFLICT (user_id, problem_id) 
       DO UPDATE SET 
         attempts = user_completions.attempts + 1
       RETURNING *`,
      [userId, problemId, category]
    );
    
    res.json({
      success: true,
      message: 'Problem marked as complete',
      completionId: result.rows[0].id
    });
  } catch (error) {
    console.error('Error marking problem as complete:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to mark problem as complete'
    });
  }
});

// Protected endpoint for getting user progress
app.get('/api/progress', checkJwt, async (req, res) => {
  try {
    const { auth0Id } = req.query;

    if (!auth0Id) {
      return res.status(400).json({
        success: false,
        error: 'Missing user information'
      });
    }

    const userResult = await query(
      'SELECT id FROM users WHERE auth0_id = $1',
      [auth0Id]
    );

    if (userResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'User not found'
      });
    }

    const userId = userResult.rows[0].id;

    // Get all problems grouped by category with completion status
    const progressQuery = `
      SELECT 
        p.category,
        COUNT(DISTINCT p.id) as total_count,
        COUNT(DISTINCT uc.problem_id) as completed_count
      FROM problems p
      LEFT JOIN user_completions uc ON p.id = uc.problem_id AND uc.user_id = $1
      GROUP BY p.category
      ORDER BY p.category
    `;
    
    const progressResult = await query(progressQuery, [userId]);
    
    // Format the response to show progress for each category
    const progress = progressResult.rows.map(row => ({
      category: row.category,
      completed: parseInt(row.completed_count) || 0,
      total: parseInt(row.total_count) || 0,
      percentage: row.total_count > 0 
        ? Math.round((parseInt(row.completed_count) / parseInt(row.total_count)) * 100)
        : 0
    }));
    
    res.json({
      success: true,
      progress: progress
    });
  } catch (error) {
    console.error('Error getting user progress:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get user progress'
    });
  }
});

// Global error handler - catches any unhandled errors
app.use((err, req, res, next) => {
  // Log the error
  console.error('Unhandled error:', err);
  
  // Send generic error response
  res.status(500).json({
    success: false,
    error: 'Internal server error'
  });
});

// Handle requests to routes that don't exist
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    error: 'Route not found'
  });
});

app.listen(PORT, () => {
  // Log server startup information
  console.log(`Server running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV}`);
  console.log(`Health check: http://localhost:${PORT}/api/health`);
});

// Export the app for testing purposes
module.exports = app;