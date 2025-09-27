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
import Problem from "./components/Problem.jsx";
import CodeEditor from "./components/CodeEditor.jsx";
import Navbar from "./components/Navbar.jsx";
import Feedback from "./components/Feedback.jsx";
import { getProblem, submitCode } from "./services/api.js";

function App() {
  {/* State management for code input and loading state */}
  const [code, setCode] = useState("");
  const [loading, setLoading] = useState(false);  // Rename later to codeLoading
  const [error, setError] = useState(null);
  const [feedback, setFeedback] = useState("");
  const [problem, setProblem] = useState(null);
  const [problemLoading, setProblemLoading] = useState(true);

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
        language: "python" 
      });
      setFeedback(result);
    } catch (error) {
      setError("Failed To Load Feedback");
      console.log('Error loading feedback:', error);
    } finally {
      setTimeout(() => setLoading(false), 500);
    }
  };
  
  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Top Navigation Bar */}
      <Navbar onSubmit={handleSubmit} onClear={handleClear} loading={loading} />
      {/* Main Content Grid Layout */}
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
            <Feedback loading={loading} feedback={feedback} error={error} />
          </div>
        </div>
        {/* Right Column: Code Editor */}
        <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
          <CodeEditor code={code} setCode={setCode} />
        </div>
      </main>
    </div>
  );
}

export default App; // Export the App component as the default export
