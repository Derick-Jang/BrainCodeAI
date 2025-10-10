import React, { useState } from 'react';
import { submitCode, requestHint, markProblemComplete } from '../services/api';
import { useAuth } from '../hooks/useAuth';
import { useProblem } from '../hooks/useProblem';
import Problem from '../components/content/Problem';
import CodeEditor from '../components/forms/CodeEditor';
import Feedback from '../components/content/Feedback';
import Navbar from '../components/layout/Navbar';
import { DEFAULT_LANGUAGE, LOADING_DELAY_MS } from '../constants/userInterfaceConstants';
import LoadingSpinner from '../components/common/LoadingSpinner';
import ErrorMessage from '../components/common/ErrorMessage';

const HomePage = () => {
  // Get auth data from hook
  const { isAuthenticated, user, getAccessTokenSilently } = useAuth();
  
  // Get problem data from hook
  const { problem, problemLoading, nextProblem } = useProblem();
  
  // Page-specific state
  const [code, setCode] = useState('');
  const [selectedLanguage, setSelectedLanguage] = useState(DEFAULT_LANGUAGE);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [feedback, setFeedback] = useState('');

  // Page-specific handlers
  const handleClear = () => {
    setCode('');
  };

  const handleSubmit = async () => {
    setLoading(true);
    setError(null);
    setFeedback('');
    try {
      const result = await submitCode({ 
        code, 
        problemTitle: problem.title, 
        language: selectedLanguage
      });
      setFeedback(result);
    } catch (error) {
      setError('Failed To Load Feedback');
      console.error('Error loading feedback:', error);
    } finally {
      setTimeout(() => setLoading(false), LOADING_DELAY_MS);
    }
  };

  const handleRequestHint = async () => {
    setLoading(true);
    setError(null);
    setFeedback('');
    try {
      const result = await requestHint(code, problem.title, selectedLanguage);
      setFeedback(result);
    } catch (error) {
      setError('Failed To Request Hint');
      console.error('Error requesting hint:', error);
    } finally {
      setTimeout(() => setLoading(false), LOADING_DELAY_MS);
    }
  };

  const handleMarkComplete = async () => {
    try {
      if (!isAuthenticated) {
        setError('Not Authenticated');
        return;
      }
      if (!problem) {
        setError('Problem Not Found');
        return;
      }
      
      setError(null);
      const token = await getAccessTokenSilently();
      await markProblemComplete(token, problem.id, problem.category, user.sub);
      handleNextProblem();
    } catch (error) {
      setError('Failed To Mark Problem As Complete');
      console.error('Error marking problem as complete:', error);
    }
  };

  const handleNextProblem = async () => {
    setCode('');
    setSelectedLanguage(DEFAULT_LANGUAGE);
    setFeedback('');
    setError(null);
    await nextProblem();
  };

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      <Navbar 
        onClear={handleClear} 
        onSubmit={handleSubmit} 
        loading={loading}
        disabled={loading}
      />
      {/* Main Content */}
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

export default HomePage;