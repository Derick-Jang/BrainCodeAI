import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuth0 } from '@auth0/auth0-react';
import { IoRefresh } from 'react-icons/io5';

/**
 * Navbar Component
 * 
 * Main navigation bar with logo, navigation links, and action buttons.
 * Shows different content based on current page and authentication state.
 * Action buttons (Reset/Submit) only appear on the homepage.
 * 
 * @param {Function} onClear - Callback for reset button click
 * @param {Function} onSubmit - Callback for submit button click
 * @param {boolean} loading - Whether an action is currently loading
 * @param {boolean} disabled - Whether buttons should be disabled
 */
const navbar = ({ onClear, onSubmit, loading, disabled }) => {
  const location = useLocation();
  const { isAuthenticated, loginWithRedirect } = useAuth0();
  const isHomePage = location.pathname === '/';
  
  return (
    <nav className="bg-white border-b border-gray-200 px-4 py-3 flex justify-between items-center">
      <div className="flex items-center gap-8">
        <div className="text-xl font-semibold text-gray-900">
          BrainCodeAI
        </div>
        <div className="flex items-center gap-6 text-base">
          <Link 
            to="/" 
            className={`transition-colors ${
              location.pathname === '/' 
                ? 'text-gray-900 font-medium' 
                : 'text-gray-500 hover:text-gray-700'
            }`}
          >
            Problems
          </Link>
          {isAuthenticated ? (
            <Link 
              to="/profile" 
              className={`transition-colors ${
                location.pathname === '/profile' 
                  ? 'text-gray-900 font-medium' 
                  : 'text-gray-500 hover:text-gray-700'
              }`}
            >
              Profile
            </Link>
          ) : (
            <button
              onClick={() => loginWithRedirect({
                authorizationParams: {
                  redirect_uri: `${window.location.origin}/profile`
                }
              })}
              className="text-gray-500 hover:text-gray-700 transition-colors"
            >
              Profile
            </button>
          )}
          {/* Placeholder for future FAQ page */}
          <span className="text-gray-400 cursor-not-allowed">FAQ</span>
        </div>
      </div>
      
      {/* Only show action buttons on homepage */}
      {isHomePage && onClear && onSubmit && (
        <div className="flex gap-3 items-center">
          <button
            onClick={onClear}
            disabled={loading || disabled}
            className="bg-white text-gray-700 px-4 py-2 rounded-lg border border-gray-300 font-medium text-sm cursor-pointer transition-all duration-200 hover:bg-gray-50 disabled:opacity-60 disabled:cursor-not-allowed flex items-center gap-2"
          >
            <IoRefresh className="w-4 h-4" />
            Reset
          </button>
          <button
            onClick={onSubmit}
            disabled={loading || disabled}
            className={`min-w-[130px] bg-gray-900 text-white px-4 py-2 rounded-lg font-medium text-sm cursor-pointer transition-all duration-200 flex items-center gap-2 ${
              loading ? 'bg-gray-500' : 'hover:bg-gray-800'
            } disabled:bg-gray-400 disabled:cursor-not-allowed`}
          >
            {loading ? (
              <>
                <span className="w-4 h-4 border-2 border-transparent border-t-current rounded-full animate-spin"></span>
                Getting Feedback...
              </>
            ) : (
              <>
                ▶ Submit Code
              </>
            )}
          </button>
        </div>
      )}
    </nav>
  );
};

export default navbar;