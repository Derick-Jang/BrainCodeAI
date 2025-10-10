import { useState, useEffect } from 'react';
import { getProblem } from '../services/api';

/**
 * Custom hook for managing problem state and operations
 * Handles fetching problems and navigation between problems
 */
export const useProblem = () => {
  const [problem, setProblem] = useState(null);
  const [problemLoading, setProblemLoading] = useState(true);

  // Fetch initial problem on mount
  useEffect(() => {
    fetchProblem();
  }, []);

  const fetchProblem = async () => {
    try {
      setProblemLoading(true);
      const problemData = await getProblem();
      setProblem(problemData);
    } catch (error) {
      console.log('Problem fetch failed:', error.message);
    } finally {
      setProblemLoading(false);
    }
  };

  const nextProblem = async () => {
    await fetchProblem();
  };

  return {
    problem,
    problemLoading,
    nextProblem
  };
};