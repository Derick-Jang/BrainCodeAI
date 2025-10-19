import React from 'react';

/**
 * ErrorBoundary Component
 * 
 * Catches JavaScript errors anywhere in the component tree and displays
 * a fallback UI instead of crashing the entire application.
 * Provides a user-friendly error page with refresh option.
 */
class errorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  /**
   * Updates state to trigger error UI when an error is caught
   * @param {Error} error - The error that was thrown
   * @returns {Object} New state indicating error occurred
   */
  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  /**
   * Logs error details for debugging purposes
   * @param {Error} error - The error that was caught
   * @param {Object} errorInfo - Additional error information
   */
  componentDidCatch(error, errorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    // Show error UI if an error was caught
    if (this.state.hasError) {
      return (
        <div className="min-h-screen bg-gray-100 flex items-center justify-center">
          <div className="text-center">
            <h1 className="text-2xl font-semibold text-gray-900 mb-4">
              Something went wrong
            </h1>
            <p className="text-gray-600 mb-4">Please refresh the page to try again.</p>
            <button
              onClick={() => window.location.reload()}
              className="bg-gray-900 text-white px-4 py-2 rounded-lg"
            >
              Refresh Page
            </button>
          </div>
        </div>
      );
    }

    // Render children normally if no error
    return this.props.children;
  }
}

export default errorBoundary;