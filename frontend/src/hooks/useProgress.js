import { useState, useEffect, useCallback } from 'react';
import { getUserProgress } from '../services/api';

export const useProgress = (isAuthenticated, userInitialized, getAccessTokenSilently, userId) => {
  const [progress, setProgress] = useState([]);
  const [progressLoading, setProgressLoading] = useState(false);
  const [progressError, setProgressError] = useState(null);

  const fetchProgress = useCallback(async () => {
    try {
      setProgressLoading(true);
      setProgressError(null);
      
      const token = await getAccessTokenSilently();
      const progressData = await getUserProgress(token, userId);
      setProgress(progressData.progress || []);
    } catch (error) {
      console.error('Error fetching progress:', error);
      setProgressError('Failed to load progress');
    } finally {
      setProgressLoading(false);
    }
  }, [getAccessTokenSilently, userId]);

  useEffect(() => {
    if (isAuthenticated && userInitialized) {
      fetchProgress();
    }
  }, [isAuthenticated, userInitialized, fetchProgress]);

  return { progress, progressLoading, progressError };
};