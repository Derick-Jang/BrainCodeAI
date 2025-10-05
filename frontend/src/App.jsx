/**
 * Main Application Component
 * 
 * Root component that orchestrates the entire coding interview platform.
 * Manages global state for code input and loading states, and coordinates
 * communication between all child components (Navbar, Problem, CodeEditor, Feedback).
 * 
 * Layout Structure:
 * - Top: Navigation bar with branding and action buttons
 * - Left Column: Problem description (top) + AI Feedback (bottom)
 * - Right Column: Code editor with line numbers and language selection
 */

import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { useAuth0 } from "@auth0/auth0-react";
import Problem from "./components/Problem.jsx";
import CodeEditor from "./components/CodeEditor.jsx";
import Navbar from "./components/Navbar.jsx";
import Feedback from "./components/Feedback.jsx";
import Profile from "./components/Profile.jsx";
import { getProblem, submitCode, registerUser, markProblemComplete, requestHint } from "./services/api.js";

function App() {
  const { isAuthenticated, isLoading, getAccessTokenSilently, user } = useAuth0();
  const [code, setCode] = useState("");
  const [selectedLanguage, setSelectedLanguage] = useState("python"); // Add this line
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [feedback, setFeedback] = useState("");
  const [problem, setProblem] = useState(null);
  const [problemLoading, setProblemLoading] = useState(true);
  const [userInitialized, setUserInitialized] = useState(false);
  const [userInitializationError, setUserInitializationError] = useState(null);

  // Initialize user when authenticated
  useEffect(() => {
    if (isAuthenticated && !userInitialized) {
      const initializeUser = async () => {
        try {
          setUserInitializationError(null);
          const token = await getAccessTokenSilently();
          await registerUser(token, user.sub, user.name, user.email);
          setUserInitialized(true);
          console.log('User initialized successfully');
        } catch (error) {
          console.error('Error initializing user:', error);
          setUserInitializationError('Failed to initialize user');
        }
      };
      initializeUser();
    }
  }, [isAuthenticated, userInitialized, getAccessTokenSilently, user]);

  // Fetch problem data from the backend when the component mounts
  useEffect(() => {
    const fetchProblem = async () => {
      try {
        setProblemLoading(true);
        const problemData = await getProblem();
        setProblem(problemData);
      } catch (error) {
        console.log('Problem fetch failed (backend not running):', error.message);
      } finally {
        setProblemLoading(false);
      }
    };
    fetchProblem();
  }, []);

  // Handles fetching the next problem
  const handleNextProblem = async () => {
    try {
      setProblemLoading(true);
      setCode("");
      setSelectedLanguage("python"); // Reset language to default
      setFeedback("");
      setError(null);

      const problemData = await getProblem();
      setProblem(problemData);
    } catch (error) {
      console.log('Failed to load next problem: ', error.message);
    } finally {
      setProblemLoading(false);
    }
  };

  // Handles clearing the code editor content
  const handleClear = () => setCode("");

  // Handles code submission for AI analysis and sets the loading state
  const handleSubmit = async () => {
    setLoading(true);
    setError(null);
    setFeedback("");
    try {
      const result = await submitCode({ 
        code, 
        problemTitle: problem.title, 
        language: selectedLanguage // Use the selected language instead of hardcoded "python"
      });
      setFeedback(result.feedback);
    } catch (error) {
      setError("Failed To Load Feedback");
      console.log('Error loading feedback:', error);
    } finally {
      setTimeout(() => setLoading(false), 500);
    }
  };

  const handleRequestHint = async () => {
    setLoading(true);
    setError(null);
    setFeedback("");
    try {
      const result = await requestHint(code, problem.title, selectedLanguage);
      setFeedback(result);
    } catch (error) {
      setError("Failed To Request Hint");
      console.log('Error requesting hint:', error);
    } finally {
      setTimeout(() => setLoading(false), 500);
    }
  };

  const handleMarkComplete = async () => {
    try{
      if (!isAuthenticated) {
        setError("Not Authenticated");
        return;
      }
      if (!problem) {
        setError("Problem Not Found");
        return;
      }
      
      setError(null);
      const token = await getAccessTokenSilently();
      const result = await markProblemComplete(token, problem.id, problem.category, user.sub);
      console.log('Problem marked as complete:', result);
      handleNextProblem();
    } catch (error) {
      setError("Failed To Mark Problem As Complete");
      console.log('Error marking problem as complete:', error);
    }
  };

  // Show loading spinner while Auth0 is initializing
  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-100 flex items-center justify-center">
        <div className="text-center">
          <div className="w-8 h-8 border-4 border-gray-300 border-t-gray-900 rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Loading...</p>
        </div>
      </div>
    );
  }
  
  return (
    <Router>
      <div className="min-h-screen bg-gray-100 flex flex-col">
        {/* Top Navigation Bar */}
        <Navbar onSubmit={handleSubmit} onClear={handleClear} loading={loading} />
        {/* Main Content */}
        <Routes>
          <Route path="/profile" element={
            <Profile 
              userInitialized={userInitialized}
              userInitializationError={userInitializationError}
            />
          } />
          <Route path="/" element={
            <main className="flex-1 p-2.5 grid grid-cols-2 gap-2.5">
              {/* Left Column: Problem and Feedback */}
              <div className="flex flex-col gap-2.5">
                {/* Problem Description Panel */}
                <div className="bg-white rounded-lg shadow-sm border h-1/2 overflow-hidden">
                  {problemLoading ? (
                    <div className="p-3">Loading Problem...</div>
                  ) : problem ? (
                    <Problem problem={problem} onNextProblem={handleNextProblem}/>
                  ) : (
                    <div className="p-3 text-red-500 flex items-center justify-center h-full">Failed to load problem</div>
                  )}
                </div>
                {/* AI Feedback Panel */}
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
              {/* Right Column: Code Editor */}
              <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
                <CodeEditor 
                  code={code} 
                  setCode={setCode} 
                  selectedLanguage={selectedLanguage}
                  setSelectedLanguage={setSelectedLanguage}
                />
              </div>
            </main>
          } />
        </Routes>
      </div>
    </Router>
  );
}

export default App; // Export the App component as the default export
