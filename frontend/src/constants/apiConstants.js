/**
 * API Configuration Constants
 * Centralized API-related values for consistent behavior across the application
 */

// API timeout in milliseconds
export const API_TIMEOUT_MS = 30000; // 30 seconds

// API base URL fallback
export const DEFAULT_API_BASE_URL = 'http://localhost:4000';

// API endpoints (if you want to centralize them)
export const API_ENDPOINTS = {
  PROBLEM: '/api/problem',
  SUBMIT: '/api/submit',
  HINT: '/api/hint',
  REGISTER: '/api/register',
  COMPLETE: '/api/complete',
  PROGRESS: '/api/progress',
  HEALTH: '/api/health'
};