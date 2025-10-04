/**
 * Navbar Component
 * 
 * Top navigation bar containing the app branding, navigation links,
 * and primary action buttons (Reset and Submit). Provides the main
 * interface for user interactions and navigation.
 * 
 * @param {Function} onSubmit - Callback function for code submission
 * @param {Function} onClear - Callback function to clear/reset the code editor
 * @param {boolean} loading - Loading state indicator for async operations
 * @param {boolean} disabled - Disable state for submit button
 * @param {JSX.Element} submitButtonContent - Rendered content for the submit button
 */

import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuth0 } from '@auth0/auth0-react';
import { IoRefresh } from 'react-icons/io5';

const Navbar = ({ onSubmit, onClear, loading, disabled}) => {
  const location = useLocation();
  const { isAuthenticated, user, loginWithRedirect, logout } = useAuth0();
  
  return (
    <nav className="bg-white border-b border-gray-200 px-4 py-3 flex justify-between items-center">
      {/* Left Section: Logo/Brand and Navigation Links */}
      <div className="flex items-center gap-8">
        {/* Application Brand/Logo */}
        <div className="text-xl font-semibold text-gray-900">
          BrainCodeAI
        </div>
        {/* Navigation Menu Items */}
        <div className="flex items-center gap-6 text-sm">
          {/* Problems page */}
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
          {/* Profile page */}
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
              className={`transition-colors ${
                location.pathname === '/profile' 
                  ? 'text-gray-900 font-medium' 
                  : 'text-gray-500 hover:text-gray-700'
              }`}
            >
              Profile
            </button>
          )}
          {/* FAQ page - placeholder for future implementation */}
          <span className="text-gray-400 cursor-not-allowed">FAQ</span>
        </div>
      </div>
      {/* Right Section: Clear and Submit Code Buttons */}
      <div className="flex gap-3 items-center">
        {/* Clear Button */}
        <button
          onClick={onClear}
          disabled={loading}
          className="bg-white text-gray-700 px-4 py-2 rounded-lg border border-gray-300 font-medium text-sm cursor-pointer transition-all duration-200 hover:bg-gray-50 disabled:opacity-60 disabled:cursor-not-allowed flex items-center gap-2"
        >
          <IoRefresh className="w-4 h-4" />
          Reset
        </button>
        {/* Submit Code Button */}
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
    </nav>
  );
};

export default Navbar;