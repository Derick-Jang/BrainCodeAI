import React from 'react';

/**
 * ErrorMessage Component For Feedback
 * 
 * Displays an error message in a styled container.
 * 
 * @param {string} message - The error message to display
 */
const ErrorMessage = ({ message }) => {
  return (
    <div className="flex items-center justify-center h-full text-red-600">
      <div className="text-center">
        <div className="mb-2">❌</div>
        <div>{message}</div>
      </div>
    </div>
  );
};

export default ErrorMessage;