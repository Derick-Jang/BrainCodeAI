/**
 * API Service Layer
 * 
 * This file provides a centralized interface for all HTTP communications
 * between the React frontend and the Express.js backend
 * Handles request configuration, error management, and data transformation.
 */

import axios from 'axios';

// ============================================================================
// CONFIGURATION SETUP
// ============================================================================

// Base URL Configuration
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000';

// Axios Instance Creation
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
});

// ============================================================================
// REQUEST/RESPONSE INTERCEPTORS (IMPLEMENT LATER)
// ============================================================================

/**
 * Request Interceptor
 * TODO: Add request interceptor to:
 * - Log outgoing requests during development
 * - Add any default headers or authentication tokens (future)
 * - Modify request config if needed
 */
api.interceptors.request.use(
  (config) => {
    // TODO: Add request logging and modifications
    return config;
  },
  (error) => {
    // TODO: Handle request setup errors
    return Promise.reject(error);
  }
);

/**
 * Response Interceptor
 * TODO: Add response interceptor to:
 * - Log successful responses during development
 * - Handle common response transformations
 * - Centralized response error handling
 */
api.interceptors.response.use(
  (response) => {
    // TODO: Add response logging and transformations
    return response;
  },
  (error) => {
    // TODO: Add centralized error handling
    return Promise.reject(error);
  }
);

// ============================================================================
// ERROR HANDLING UTILITIES
// ============================================================================

/**
 * Error Transformation Helper
 * Handles these cases:
 * - Network errors (error.response is undefined)
 * - HTTP status errors (4xx, 5xx with error.response.data)
 * - Timeout errors
 * - Generic errors
 */
const transformError = (error) => {
  if (!error.response) {
    if (error.code === "ECONNABORTED") {
      return "Request timed out. Please try again later.";
    }
    if (error.code === "ERR_NETWORK") {
      return "Network Error. Please check your internet connection";
    }
    return "Connection failed. Please check if the backend server is running.";
  }

  const status = error.response.status;
  const data = error.response.data;
  
  // Extract server message from various common formats
  const serverErrorMessage = typeof data === 'string' ? data : 
                        data?.message || data?.error || data?.detail;

  // Handle specific status codes with fallbacks
  if (status === 400) {
    return serverErrorMessage || "Invalid request. Please check your input.";
  }
  if (status === 401) {
    return "Authentication required. Please log in.";
  }
  if (status === 403) {
    return "Access denied.";
  }
  if (status === 404) {
    return "The requested resource was not found";
  }
  if (status === 429) {
    return "Too many requests. Please wait and try again.";
  }
  if (status >= 500) {
    return "An internal server error occurred. Please try again later.";
  }

  // Default fallback with server message if available
  return serverErrorMessage || "An unknown error occurred. Please try again later.";
};

/**
 * Input Validation Helper
 * Should check:
 * - Required parameters are present
 * - String parameters are not empty after trimming
 * - Parameter types are correct
 */
const validateInput = (params, requiredFields) => {
  // Check if params object exists
  if (!params || typeof params !== 'object') {
    throw new Error('Parameters object is required');
  }

  // Loop through required fields and validate each
  for (const field of requiredFields) {
    const value = params[field];
    
    // Check if field exists
    if (value === undefined || value === null) {
      throw new Error(`${field} is required`);
    }
    
    // For strings, check if empty after trimming
    if (typeof value === 'string') {
      if (value.trim() === '') {
        throw new Error(`${field} cannot be empty`);
      }
    }
    
    // Type-specific validation
    if (field === 'code' && typeof value !== 'string') {
      throw new Error('code must be a string');
    }
    
    if (field === 'problemTitle' && typeof value !== 'string') {
      throw new Error('problemTitle must be a string');
    }
  }
};

// ============================================================================
// API FUNCTIONS
// ============================================================================

/**
 * Submit Code for AI Feedback
 * TODO: Implement function that sends user code to backend for analysis
 * 
 * @param {Object} params - Parameters object
 * @param {string} params.code - User's code solution
 * @param {string} params.problemTitle - Title of the current problem
 * @param {string} [params.language] - Programming language (optional)
 * @returns {Promise<Object>} Promise resolving to feedback object
 * 
 * Implementation steps:
 * 1. Validate input parameters using validateInput helper
 * 2. Make POST request to /api/feedback endpoint (adjust path as needed)
 * 3. Send { code, problem_title, language } in request body
 * 4. Extract and return response.data
 * 5. Use transformError for error handling
 */
export const submitCode = async ({ code, problemTitle, language = 'python' }) => {
  try {
    // Validate required parameters
    validateInput({ code, problemTitle, language }, ['code', 'problemTitle']);

    // Create payload matching backend Submission model
    const payload = {
        problem_id: problemTitle.toLowerCase().replace(/\s+/g, '-'), // ✅ Matches backend model
        language: language,
        code: code.trim(),
        notes: null  // Optional but good to include
    };

    // Send request to backend
    const response = await api.post('/submissions', payload);

    // Return response data
    return {
        message: response.data.message || "Code submitted successfully",
        submission: response.data.submission,
        // FUTURE IMPLEMENTATION: Add AI feedback fields when backend implements AI analysis
        // analysis: response.data.analysis,
        // suggestions: response.data.suggestions,
        // score: response.data.score,
        // hints: response.data.hints,
    };
  } catch (error) {
    const errorMessage = transformError(error);
    throw new Error(errorMessage);
  }
};

/**
 * Test Backend Connection
 * TODO: Implement function to verify backend is accessible
 * 
 * @returns {Promise<boolean>} Promise resolving to connection status
 * 
 * Implementation steps:
 * 1. Make GET request to health check endpoint (e.g., '/' or '/health')
 * 2. Return true if successful response received
 * 3. Return false if any error occurs (don't throw)
 * 4. Consider adding timeout for faster feedback
 */
export const testConnection = async () => {
  try {
    // TODO: Make health check request
    // Should be a simple GET request to verify server is responding
    
    // TODO: Return true for successful connection
    
  } catch (error) {
    // TODO: Log error but return false (don't throw)
    // This function should never throw errors - just return boolean
  }
};

/**
 * Get Problem Data (Future Implementation)
 * TODO: For later iterations when problems come from database
 * 
 * @param {string|number} problemId - ID of the problem to fetch
 * @returns {Promise<Object>} Promise resolving to problem object
 */
export const getProblem = async (problemId) => {
  try {
    // TODO: Future implementation for database-driven problems
    // Will make GET request to /api/problems/:id
    // For now, this can return mock data or throw "not implemented"
    
    throw new Error('getProblem not yet implemented - using hardcoded problem data');
  } catch (error) {
    // TODO: Error handling
  }
};

/**
 * Request Hint (Future Implementation)
 * TODO: For iteration 3 when hint system is added
 * 
 * @param {Object} params - Parameters object
 * @param {string} params.code - Current user code
 * @param {string} params.problemTitle - Problem title
 * @returns {Promise<Object>} Promise resolving to hint object
 */
export const requestHint = async ({ code, problemTitle }) => {
  try {
    // TODO: Future implementation for hint requests
    // Will make POST request to /api/hint endpoint
    // For now, this can throw "not implemented"
    
    throw new Error('requestHint not yet implemented - planned for iteration 3');
  } catch (error) {
    // TODO: Error handling
  }
};

// ============================================================================
// DEVELOPMENT UTILITIES (IMPLEMENT LATER)
// ============================================================================

/**
 * Development Logging Helper
 * TODO: Add conditional logging that only runs in development
 * Use import.meta.env.DEV to check if in development mode
 */
const devLog = (message, data) => {
  // TODO: Check if in development mode and log accordingly
  // Consider using different log levels (info, warn, error)
  // Format logs consistently for easier debugging
};

/**
 * API Configuration Validator
 * Validate API configuration on startup
 * Check that required environment variables are present
 * Warn about common configuration issues
 */
const validateApiConfig = () => {
  if (!import.meta.env.DEV) return;
  // 1. Check environment variables
  const apiUrl = import.meta.env.VITE_API_BASE_URL; // Points to the backend URL
  console.log('🔧 API Configuration:');
  console.log(`   Base URL: ${API_BASE_URL}`);
  // 2. Warn about missing env vars
  if (!apiUrl) {
    console.warn('⚠️  VITE_API_BASE_URL not set, using fallback localhost');
  }
  // 3. Check for localhost issues
  if (apiUrl?.includes('localhost') || API_BASE_URL.includes('localhost')) {
    console.info('ℹ️  Using localhost - ensure backend is running');
  }
  // 4. Validate URL format
  try {
    new URL(API_BASE_URL);
    console.log('✅ API URL format is valid');
  } catch {
    console.error('❌ Invalid API URL format');
  }
};
// Call configuration validator when module loads (development only)
if (import.meta.env.DEV) {
  validateApiConfig();
}

// ============================================================================
// EXPORTS
// ============================================================================

/**
 * Export the configured axios instance for advanced usage
 * Most components should use the specific API functions above,
 * but this allows direct access if needed
 */
export { api };

/**
 * Export API configuration for debugging
 * Useful for troubleshooting connection issues
 */
export const apiConfig = {
  baseURL: API_BASE_URL,
  timeout: 30000,
  environment: import.meta.env.DEV ? 'development' : 'production',
  isDev: import.meta.env.DEV,
  envVariables: {
    VITE_API_BASE_URL: API_BASE_URL
  },

  headers: {
    'Content-Type': 'application/json'
  }
};