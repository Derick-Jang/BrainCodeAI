import axios from 'axios';
import { DEFAULT_API_BASE_URL, API_TIMEOUT_MS, API_ENDPOINTS } from '../constants/apiConstants';
import { validateUserRegistration, validateProblemCompletion, validateCodeSubmission, validateHintRequest } from './validationService';

// API base URL from environment variable or default to constant fallback
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || DEFAULT_API_BASE_URL;

// Configure axios instance with base settings
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: API_TIMEOUT_MS, // 30 second timeout to prevent hanging requests
  headers: {
    'Content-Type': 'application/json'
  }
});

/**
 * Fetches a random coding problem from the backend
 * @returns {Promise<Object>} Problem object with title, description, examples, etc.
 * @throws {Error} If problem fetch fails
 */
const getProblem = async () => {
  try {
    const response = await api.get(API_ENDPOINTS.PROBLEM);
    return response.data.data; // Extract problem data from API response
  } catch (error) {
    console.error('Error fetching problem:', error);
    throw new Error('Failed to load problem. Please try again later.');
  }
};

/**
 * Submits user's code solution for AI evaluation and feedback
 * @param {Object} params - Submission parameters
 * @param {string} params.code - User's code solution
 * @param {string} params.problemTitle - Title of the problem being solved
 * @param {string} [params.language='python'] - Programming language used
 * @returns {Promise<string>} AI-generated feedback on the code
 * @throws {Error} If validation or submission fails
 */
const postSubmitCode = async ({ code, problemTitle, language = 'python' }) => {
  // Validate input data
  const validationResult = validateCodeSubmission({
    code,
    problemTitle,
    language
  });

  if (!validationResult.success) {
    throw new Error(validationResult.error);
  }

  try {
    const response = await api.post(API_ENDPOINTS.SUBMIT, validationResult.data);
    return response.data.data.feedback; // Extract feedback from response
  } catch (error) {
    console.error('Error submitting code:', error);
    // Handle backend validation errors if any slip through
    if (error.response?.data?.details) {
      const backendErrors = error.response.data.details
        .map(detail => detail.message)
        .join(', ');
      throw new Error(backendErrors);
    }
    throw new Error(error.response?.data?.error || 'Failed to submit code. Please try again later.');
  }
};

/**
 * Registers a new user in the backend database
 * Required for progress tracking and problem completion features
 * @param {string} token - Auth0 access token for authentication
 * @param {string} id - Auth0 user ID (sub claim)
 * @param {string} name - User's display name
 * @param {string} email - User's email address
 * @returns {Promise<Object>} Registration response data
 * @throws {Error} If validation or registration fails
 */
const postRegisterUser = async (token, id, name, email) => {
  // Validate user registration data
  const validationResult = validateUserRegistration({
    auth0Id: id,
    name: name,
    email: email
  });

  if (!validationResult.success) {
    throw new Error(validationResult.error);
  }

  try {
    const response = await api.post(API_ENDPOINTS.REGISTER, 
      validationResult.data, 
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    );
    console.log('User registered successfully:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error registering user:', error);
    // Handle backend validation errors if any slip through
    if (error.response?.data?.details) {
      const backendErrors = error.response.data.details
        .map(detail => detail.message)
        .join(', ');
      throw new Error(backendErrors);
    }
    throw new Error(error.response?.data?.error || 'Failed to register user. Please try again later.');
  }
};

/**
 * Requests a hint for the current problem and code
 * @param {Object} params - Hint request parameters
 * @param {string} params.code - User's current code
 * @param {string} params.problemTitle - Title of the problem
 * @param {string} params.language - Programming language
 * @returns {Promise<string>} AI-generated hint
 * @throws {Error} If validation or hint request fails
 */
const postRequestHint = async ({ code, problemTitle, language }) => {
  // Validate input data
  const validationResult = validateHintRequest({
    code,
    problemTitle,
    language
  });

  if (!validationResult.success) {
    throw new Error(validationResult.error);
  }

  try {
    const response = await api.post(API_ENDPOINTS.HINT, validationResult.data);
    console.log('Hint requested successfully:', response.data);
    return response.data.hint;
  } catch (error) {
    console.error('Error requesting hint:', error);
    // Handle backend validation errors if any slip through
    if (error.response?.data?.details) {
      const backendErrors = error.response.data.details
        .map(detail => detail.message)
        .join(', ');
      throw new Error(backendErrors);
    }
    throw new Error(error.response?.data?.error || 'Failed to request hint. Please try again later.');
  }
};

/**
 * Marks a problem as completed for the user
 * Updates progress tracking and unlocks next problems
 * @param {string} token - Auth0 access token
 * @param {string} problemId - Unique problem identifier
 * @param {string} category - Problem category (e.g., "Arrays-&-Hashing")
 * @param {string} auth0Id - User's Auth0 ID
 * @returns {Promise<Object>} Completion response data
 * @throws {Error} If validation or marking complete fails
 */
const postMarkProblemComplete = async (token, problemId, category, auth0Id) => {
  // Validate problem completion data
  const validationResult = validateProblemCompletion({
    problemId: problemId,
    category: category,
    auth0Id: auth0Id
  });

  if (!validationResult.success) {
    throw new Error(validationResult.error);
  }

  try {
    const response = await api.post(API_ENDPOINTS.COMPLETE, 
      validationResult.data,
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    );
    console.log('Problem marked as complete:', response.data);
    return response.data.data;
  } catch (error) {
    console.error('Error marking problem as complete:', error);
    // Handle backend validation errors if any slip through
    if (error.response?.data?.details) {
      const backendErrors = error.response.data.details
        .map(detail => detail.message)
        .join(', ');
      throw new Error(backendErrors);
    }
    throw new Error(error.response?.data?.error || 'Failed to mark problem as complete. Please try again later.');
  }
};

/**
 * Retrieves user's progress across all problem categories
 * @param {string} token - Auth0 access token
 * @param {string} auth0Id - User's Auth0 ID
 * @returns {Promise<Array>} Array of category progress objects
 * @throws {Error} If progress fetch fails
 */
const getUserProgress = async (token, auth0Id) => {
  try{
    const response = await api.get(`${API_ENDPOINTS.PROGRESS}?auth0Id=${auth0Id}`, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    });
    return response.data.data;
  } catch (error) {
    console.error('Error getting user progress:', error);
    throw new Error('Failed to get user progress. Please try again later.');
  }
};

/**
 * Tests backend connection health
 * Used for debugging and monitoring backend availability
 * @returns {Promise<Object>} Health status object
 */
const getTestConnection = async () => {
  try {
    const response = await api.get(API_ENDPOINTS.HEALTH);
    return response.data;
  } catch (error) {
    console.error('Health check failed:', error);
    return { status: 'ERROR', message: 'Backend not reachable' };
  }
};

// Export all functions
export {
  getProblem,
  postSubmitCode,
  postRegisterUser,
  postRequestHint,
  postMarkProblemComplete,
  getUserProgress,
  getTestConnection
};

export default api;

