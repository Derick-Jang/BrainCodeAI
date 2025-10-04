import axios from 'axios';

// API base URL from environment variable or default to localhost
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:4000';

// Configure axios instance with base settings
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Fetch a coding problem from the backend
export const getProblem = async () => {
  try {
    const response = await api.get('/api/problem');
    return response.data.problemData; // Type: Javascript object
  } catch (error) {
    console.error('Error fetching problem:', error);
    throw new Error('Failed to load problem. Please try again later.');
  }
};

// Submit code solution for evaluation
export const submitCode = async ({ code, problemTitle, language = 'python' }) => {
  try {
    const response = await api.post('/api/submit', 
      { code, problemTitle, language }
    );
    
    return {
      feedback: response.data.data.feedback
    };
  } catch (error) {
    console.error('Error submitting code:', error);
    throw new Error('Failed to submit code. Please try again later.');
  }
};

// Register user in database (ensures user exists for progress tracking)
export const registerUser = async (token, id, name, email) => {
  try {
    const response = await api.post('/api/register', 
    {
      auth0Id: id,
      name: name,
      email: email
    }, 
    {
      headers: {
        Authorization: `Bearer ${token}`
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error registering user:', error);
    throw new Error('Failed to register user. Please try again later.');
  }
};

// Stub functions for testing - replace with real implementations later
export const getUserProgress = async (token) => {
  console.log('getUserProgress called (stub)');
  return []; // Return empty array for now
};

export const markProblemComplete = async (token, problemId) => {
  console.log('markProblemComplete called (stub)');
  return { success: true, message: 'Problem marked as complete (stub)' };
};

// Test backend connection health
export const testConnection = async () => {
  try {
    const response = await api.get('/api/health');
    return response.data;
  } catch (error) {
    console.error('Health check failed:', error);
    return { status: 'ERROR', message: 'Backend not reachable' };
  }
};

export default api;

