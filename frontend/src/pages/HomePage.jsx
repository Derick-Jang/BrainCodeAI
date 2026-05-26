import { useState } from 'react';
import { postSubmitCode, postRequestHint, postMarkProblemComplete } from '../services/api';
import useAuth from '../hooks/useAuth';
import useProblem from '../hooks/useProblem';
import Problem from '../components/content/problem';
import CodeEditor from '../components/forms/codeEditor';
import Feedback from '../components/content/feedback';
import Navbar from '../components/layout/navbar';
import { DEFAULT_LANGUAGE, LOADING_DELAY_MS } from '../constants/codeEditorConstants';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/errorMessage';

/**
 * HomePage Component
 * 
 * Main application interface where users solve coding problems.
 * Features a split-screen layout with problem description on the upper left, 
 * AI feedback panel on the lower left, and code editor on the right
 * 
 */
const homePage = () => {
  // Authentication state from custom hook
  const { isAuthenticated, user, getAccessTokenSilently } = useAuth();
  
  // Problem data from custom hook
  const { problem, problemLoading, nextProblem } = useProblem();
  
  // Local component state
  const [code, setCode] = useState('');
  const [selectedLanguage, setSelectedLanguage] = useState(DEFAULT_LANGUAGE);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [feedback, setFeedback] = useState('');

  /**
   * Clears the code editor content
   * Used by the Reset button in the navbar
   */
  const handleClear = () => {
    setCode('');
  };

  /**
   * Submits user's code for AI evaluation
   * Sends code to backend for analysis and displays feedback
   */
  const handleSubmit = async () => {
    if (!problem) {
      setError('No problem selected');
      return;
    }

    // Clear previous state
    setError(null);
    setFeedback('');
    setLoading(true);

    try {
      const result = await postSubmitCode({
        code,
        problemTitle: problem.title,
        language: selectedLanguage
      });
      setFeedback(result);
    } catch (error) {
      setError(error.message);
      console.error('Error loading feedback:', error);
    } finally {
      // Add delay to prevent UI flashing for quick responses
      setTimeout(() => setLoading(false), LOADING_DELAY_MS);
    }
  };

  /**
   * Requests a hint for the current problem
   * AI analyzes current code and provides targeted guidance
   */
  const handleRequestHint = async () => {
    if (!problem) {
      setError('No problem selected');
      return;
    }

    // Clear previous state
    setError(null);
    setFeedback('');
    setLoading(true);

    try {
      const result = await postRequestHint({
        code,
        problemTitle: problem.title,
        language: selectedLanguage
      });
      setFeedback(result);
    } catch (error) {
      setError(error.message);
      console.error('Error requesting hint:', error);
    } finally {
      // Add delay to prevent UI flashing for quick responses
      setTimeout(() => setLoading(false), LOADING_DELAY_MS);
    }
  };

  /**
   * Moves to the next random problem
   * Resets all form state and fetches new problem
   */
  const handleNextProblem = async () => {
    setCode('');
    setFeedback('');
    setError(null);
    await nextProblem();
  };

  /**
   * Marks the current problem as completed
   * Updates user progress and moves to next problem
   * Requires authentication
   */
  const handleMarkComplete = async () => {
    if (!isAuthenticated) {
      setError('Not Authenticated. Please login to track your progress.');
      return;
    }
    if (!problem) {
      setError('Problem Not Found');
      return;
    }

    setError(null);
    
    try {
      const token = await getAccessTokenSilently();
      await postMarkProblemComplete(token, problem.id, problem.category, user.sub);
      handleNextProblem();
    } catch (error) {
      setError(error.message);
      console.error('Error marking problem as complete:', error);
    }
  };

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      <Navbar 
        onClear={handleClear} 
        onSubmit={handleSubmit} 
        loading={loading}
        disabled={loading}  // Buttons are disabled when loading
      />
      <main className="flex-1 p-2.5 grid grid-cols-2 gap-2.5">
        <div className="flex flex-col gap-2.5">
          <div className="bg-white rounded-lg shadow-sm border h-1/2 overflow-hidden">
            {problemLoading ? (
              <LoadingSpinner message="Loading Problem..." />
            ) : problem ? (
              <Problem problem={problem} onNextProblem={handleNextProblem} />
            ) : (
              <ErrorMessage message="Failed to load problem" />
            )}
          </div>
          <div className="h-1/2">
            <Feedback 
              loading={loading} 
              feedback={feedback} 
              error={error} 
              onRequestHint={handleRequestHint}
              onMarkComplete={handleMarkComplete}
            />
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
          <CodeEditor 
            code={code} 
            setCode={setCode} 
            selectedLanguage={selectedLanguage}
            setSelectedLanguage={setSelectedLanguage}
          />
        </div>
      </main>
    </div>
  );
};

export default homePage;