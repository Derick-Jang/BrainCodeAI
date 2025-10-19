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
 * @param {Function} onRequestHint - Callback for hint request button
 * @param {Function} onMarkComplete - Callback for marking problem complete
 */

import { SiOpenai } from 'react-icons/si';
import { IoChatbubbleEllipsesOutline } from 'react-icons/io5';
import LoadingSpinner from '../common/loadingSpinner';
import ErrorMessage from '../common/errorMessage';

const feedback = ({ feedback, error, loading, onRequestHint, onMarkComplete }) => {
  return (
    <div className="bg-white rounded-lg shadow-sm border h-full">
      <div className="h-full flex flex-col">
        <div className="px-4 py-2 bg-green-200 font-semibold text-sm text-gray-800 border-b border-green-300 flex justify-between items-center gap-1.5">
          <div className="flex items-center gap-1.5">
            <IoChatbubbleEllipsesOutline className="w-4 h-4" />
            AI Feedback
          </div>
          <button 
            onClick={onRequestHint}
            className="px-3 py-2 bg-green-400 hover:bg-green-500 text-white text-sm font-medium rounded-lg transition-colors duration-200 flex items-center gap-2"
          >
            Request Hint 💡
          </button>
        </div>
        <div className="flex-1 p-2 text-gray-800 overflow-y-auto">
          {loading ? (
            <LoadingSpinner message="Getting feedback..." />
          ) : error ? (
            <ErrorMessage message={error} />
          ) : feedback ? (
            <div className="text-gray-700 text-sm">
              <div className="font-medium mb-2 flex items-center gap-2">
                <SiOpenai className="w-4 h-4" />
              </div>
              <pre className="whitespace-pre-wrap break-words font-sans leading-relaxed">{feedback}</pre>
            </div>
          ) : (
            <div className="flex items-center justify-center h-full text-gray-500">
              Submit your code to receive AI feedback and hints!
            </div>
          )}
        </div>
        
        {feedback && (
          <div className="p-3 border-t border-gray-200 flex justify-center">
            <button 
              onClick={onMarkComplete}
              className="px-3 py-3 bg-green-500 hover:bg-green-600 text-white text-sm font-medium rounded-lg transition-colors duration-200 flex items-center"
            >
              Mark As Complete ✓
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default feedback;
