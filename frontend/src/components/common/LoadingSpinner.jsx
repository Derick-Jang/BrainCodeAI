/**
 * LoadingSpinner Component
 * 
 * Reusable loading spinner with customizable message and container size.
 * Used throughout the app to indicate async operations in progress.
 * 
 * @param {string} [message='Loading...'] - The loading message to display
 * @param {boolean} [fullScreen=false] - Whether to take full screen height
 */
const loadingSpinner = ({ message = 'Loading...', fullScreen = false }) => {
  // Choose container class based on fullScreen prop
  const containerClass = fullScreen 
    ? "flex items-center justify-center min-h-screen" 
    : "flex items-center justify-center h-full";
    
  return (
    <div className={containerClass}>
      <div className="text-center">
        {/* Animated spinning circle */}
        <div className="w-8 h-8 border-4 border-gray-300 border-t-gray-900 rounded-full animate-spin mx-auto mb-4"></div>
        <p className="text-gray-600">{message}</p>
      </div>
    </div>
  );
};

export default loadingSpinner;