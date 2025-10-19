import { useState, useEffect, useCallback } from 'react';
import { getUserProgress } from '../services/api';

/**
 * Custom hook for managing user progress across problem categories
 * 
 * Fetches and manages user's completion progress for different problem categories
 * (e.g., Arrays & Hashing, Dynamic Programming, etc.). Only loads when user is
 * authenticated and initialized in the backend.
 * 
 * @param {boolean} isAuthenticated - Whether user is logged in
 * @param {boolean} userInitialized - Whether user is registered in backend
 * @param {Function} getAccessTokenSilently - Function to get fresh access tokens
 * @param {string} userId - User's Auth0 ID for progress lookup
 * @returns {Object} Progress state and loading information
 * @returns {Array} progress - Array of category progress objects
 * @returns {boolean} progressLoading - Whether progress is currently being fetched
 * @returns {string|null} progressError - Error message if progress fetch failed
 */
const useProgress = (isAuthenticated, userInitialized, getAccessTokenSilently, userId) => {
  const [progress, setProgress] = useState([]);
  const [progressLoading, setProgressLoading] = useState(false);
  const [progressError, setProgressError] = useState(null);

  /**
   * Fetches user's progress data from the backend
   * Memoized to prevent unnecessary re-fetches
   */
  const fetchProgress = useCallback(async () => {
    try {
      setProgressLoading(true);
      setProgressError(null);
      
      const token = await getAccessTokenSilently();
      const progressData = await getUserProgress(token, userId);
      setProgress(progressData || []);
    } catch (error) {
      console.error('Error fetching progress:', error);
      setProgressError('Failed to load progress');
    } finally {
      setProgressLoading(false);
    }
  }, [getAccessTokenSilently, userId]);

  // Only fetch progress when user is fully authenticated and initialized
  useEffect(() => {
    if (isAuthenticated && userInitialized) {
      fetchProgress();
    }
  }, [isAuthenticated, userInitialized, fetchProgress]);

  return { progress, progressLoading, progressError };
};

export default useProgress;