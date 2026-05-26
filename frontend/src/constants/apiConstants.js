/**
 * API Configuration Constants
 * 
 * Centralized API-related values for consistent behavior across the application.
 * All API timeouts, endpoints, and base URLs are defined here to avoid magic numbers
 * and ensure easy maintenance when backend changes.
 */

// API timeout in milliseconds - prevents hanging requests
export const API_TIMEOUT_MS = 30000; // 30 seconds

// Default API base URL for development - overridden by environment variable in production
export const DEFAULT_API_BASE_URL = 'http://localhost:4000';

// Centralized API endpoint definitions
// All backend routes are defined here to prevent typos and enable easy refactoring
export const API_ENDPOINTS = {
  PROBLEM: '/api/problems/random',      // Fetch random coding problems
  SUBMIT: '/api/code/submissions',    // Submit code for AI evaluation
  HINT: '/api/code/hints',            // Request hints for current problem
  REGISTER: '/api/users',             // Register new user in backend
  COMPLETE: '/api/users/completions', // Mark problem as completed
  PROGRESS: '/api/users/progress',    // Get user's progress by category
  HEALTH: '/api/health'               // Backend health check endpoint
};