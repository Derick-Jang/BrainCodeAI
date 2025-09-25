const express = require('express');
const OpenAI = require('openai');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

// Create an Express application instance - this is our web server
const app = express();
// Set the port number - use environment variable PORT or default to 5000
const PORT = process.env.PORT || 4000;

// Initialize OpenAI client with our API key from environment variables
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// Enable CORS (Cross-Origin Resource Sharing) - allows frontend to call this API
/*
app.use(cors({
  origin: true, // Allow all origins for development
  credentials: false,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Accept'],
  optionsSuccessStatus: 200
}));
*/

app.use(cors());
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
// Apply rate limiting to all API routes (anything starting with /api/)
// Temporarily disabled for development
// app.use('/api/', limiter);

// Store problem data in memory - for MVP we only have one problem
const PROBLEMS = {
  'two-sum': { // Problem ID as the key
    id: 'two-sum', // Unique identifier for this problem
    number: 1, // Problem number
    title: 'Two Sum', // Display name of the problem
    difficulty: 'Easy', // Difficulty level
    description: `Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.`, // Full problem description
    
    constraints: [ // Array of problem constraints
      '2 <= nums.length <= 10^4', // Array size constraint
      '-10^9 <= nums[i] <= 10^9', // Number range constraint
      '-10^9 <= target <= 10^9', // Target range constraint
      'Only one valid answer exists.' // Uniqueness constraint
    ],
    
    examples: [ // Array of example inputs and outputs
      {
        input: 'nums = [2,7,11,15], target = 9', // Example input
        output: '[0,1]', // Expected output
        explanation: 'Because nums[0] + nums[1] == 9, we return [0, 1].' // Why this output
      },
      {
        input: 'nums = [3,2,4], target = 6',
        output: '[1,2]',
        explanation: 'Because nums[1] + nums[2] == 6, we return [1, 2].'
      },
      {
        input: 'nums = [3,3], target = 6',
        output: '[0,1]',
        explanation: 'Because nums[0] + nums[1] == 6, we return [0, 1].'
      }
    ],
    
    testCases: [ // Array of test cases for validation
      { input: '[2,7,11,15], 9', expectedOutput: '[0,1]' },
      { input: '[3,2,4], 6', expectedOutput: '[1,2]' },
      { input: '[3,3], 6', expectedOutput: '[0,1]' }
    ]
  }
};

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
app.get('/api/problem', (req, res) => {
  try {
    // Get the two-sum problem from our PROBLEMS object
    const problem = PROBLEMS['two-sum'];
    
    // Send back success response with problem data
    res.json({
      success: true, // Request was successful
      data: problem // The problem data
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
    // PROBLEM VALIDATION SHOULD BE DONE IN THE FRONTEND OR NOT REQUIRED
    // ============================================================================
    
    // For MVP, we only handle the two-sum problem
    const problem = PROBLEMS['two-sum'];
    
    // Check if problem exists (should always be true for MVP)
    if (!problem) {
      return res.status(404).json({
        success: false,
        error: 'Problem not found'
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
        problemTitle: problemTitle // Which problem this was for
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

// ============================================================================
// ERROR HANDLING MIDDLEWARE
// ============================================================================

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

// ============================================================================
// 404 HANDLER
// ============================================================================

// Handle requests to routes that don't exist
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    error: 'Route not found'
  });
});

// ============================================================================
// START SERVER
// ============================================================================

// Start the server and listen on the specified port
app.listen(PORT, () => {
  // Log server startup information
  console.log(`Server running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV}`);
  console.log(`Health check: http://localhost:${PORT}/api/health`);
});

// Export the app for testing purposes
module.exports = app;