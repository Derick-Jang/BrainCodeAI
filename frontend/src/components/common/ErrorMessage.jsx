import React from 'react';

/**
 * ErrorMessage Component
 * 
 * Displays error messages in a consistent, user-friendly format.
 * Used throughout the app to show API errors and other failure states.
 * 
 * @param {string} message - The error message to display
 */
const errorMessage = ({ message }) => {
  return (
    <div className="flex items-center justify-center h-full text-red-600">
      <div className="text-center">
        <div className="mb-2">❌</div>
        <div>{message}</div>
      </div>
    </div>
  );
};

export default errorMessage;