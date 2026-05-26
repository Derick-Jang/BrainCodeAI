import { useState, useEffect } from 'react';
import { getProblem } from '../services/api';
/**
 * Custom hook for managing coding problem state and operations
 * 
 * Handles fetching random problems from the backend and provides navigation
 * between problems. Each problem includes title, description, examples, and constraints.
 * 
 * @returns {Object} Problem state and operations
 * @returns {Object|null} problem - Current problem object or null if not loaded
 * @returns {boolean} problemLoading - Whether a problem is currently being fetched
 * @returns {Function} nextProblem - Function to fetch the next random problem
 */
const useProblem = () => {
  const [problem, setProblem] = useState(null);
  const [problemLoading, setProblemLoading] = useState(true);

  /**
   * Fetches a new problem from the backend
   * Handles loading states and error management
   */
  const fetchProblem = async () => {
    try {
      setProblemLoading(true);
      const problemData = await getProblem();
      setProblem(problemData);
    } catch (error) {
      console.error('Failed to load problem:', error);
    } finally {
      setProblemLoading(false);
    }
  };

  // Fetch initial problem when component mounts
  useEffect(() => {
    fetchProblem();
  }, []);

  /**
   * Fetches the next random problem
   * Used when user wants to skip current problem
   */
  const nextProblem = async () => {
    await fetchProblem();
  };

  return {
    problem,
    problemLoading,
    nextProblem
  };
};

export default useProblem;