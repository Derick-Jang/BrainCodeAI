/**
 * Feedback Component
 * 
 * Displays AI-generated feedback and analysis for submitted code.
 * Shows different states: loading, error, feedback content, or placeholder.
 * Provides users with hints, suggestions, and code analysis.
 * 
 * @param {string} feedback - AI-generated feedback text content
 * @param {string} error - Error message if feedback generation failed
 * @param {boolean} loading - Loading state while waiting for AI response
 */

import React from 'react';
import { SiOpenai } from "react-icons/si";

const Feedback = ({ feedback, error, loading }) => {
  return (
    <div className="bg-white rounded-lg shadow-sm border h-full">
      <div className="h-full flex flex-col">
        {/* Header with AI icon and title */}
        <div className="px-4 py-2 bg-green-200 font-semibold text-xs text-gray-800 border-b border-green-300 flex items-center gap-1.5">
          <SiOpenai className="w-4 h-4" />
          AI Feedback
        </div>
        {/* Main content area with conditional rendering */}
        <div className="flex-1 p-2 text-gray-800 overflow-y-auto">
          {loading ? ( // Loading State: Spinner and message
            <div className="flex items-center justify-center h-full">
              <div className="flex flex-col items-center gap-2">
                <div className="w-6 h-6 border-2 border-gray-200 border-t-emerald-500 rounded-full animate-spin"></div> {/* Animated loading spinner */}
                <p className="text-gray-500 text-sm">Getting feedback...</p>
              </div>
            </div>
          ) : error ? ( // Error State: Display error message
            <div className="flex items-center justify-center h-full text-red-700 text-sm">
              <div className="text-center">
                <div className="mb-2">❌</div>
                <div className="text-red-500">{error}</div>
              </div>
            </div>
          ) : feedback ? ( // Feedback Content: Display AI-generated feedback
            <div className="text-gray-700 text-sm">
              <div className="font-medium mb-2 flex items-center gap-2">
                <SiOpenai className="w-4 h-4" /> {/* Same icon as header for consistency */}
              </div>
              <pre className="whitespace-pre-wrap break-words font-sans leading-relaxed">{feedback}</pre> {/* Pre-formatted text to preserve feedback formatting */}
            </div>
          ) : ( // Placeholder State: Instructions for user
            <div className="flex items-center justify-center h-full text-gray-500">
              Submit your code to receive AI feedback and hints!
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Feedback;
