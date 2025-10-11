import React from 'react';

/**
 * LoadingSpinner Component For Feedback
 * 
 * Displays a loading spinner in a styled container.
 * 
 * @param {string} message - The loading message to display
 * @param {boolean} fullScreen - Whether to take full screen height (default: false)
 */
const LoadingSpinner = ({ message = 'Loading...', fullScreen = false }) => {
  const containerClass = fullScreen 
    ? "flex items-center justify-center min-h-screen" 
    : "flex items-center justify-center h-full";
    
  return (
    <div className={containerClass}>
      <div className="text-center">
        <div className="w-8 h-8 border-4 border-gray-300 border-t-gray-900 rounded-full animate-spin mx-auto mb-4"></div>
        <p className="text-gray-600">{message}</p>
      </div>
    </div>
  );
};

export default LoadingSpinner;