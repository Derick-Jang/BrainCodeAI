import { useAuth0 } from '@auth0/auth0-react';
import { IoLogOutOutline } from 'react-icons/io5';
import useAuth from '../hooks/useAuth';
import useProgress from '../hooks/useProgress';
import LoadingSpinner from '../components/common/LoadingSpinner';
import Navbar from '../components/layout/navbar';

/**
 * ProfilePage Component
 * 
 * Displays user profile information and progress tracking across problem categories.
 * Shows completion statistics with visual progress bars for each category.
 * Requires authentication to access.
 */
const profilePage = () => {
  const { user, isAuthenticated, isLoading, userInitialized, getAccessTokenSilently } = useAuth();
  const { logout, loginWithRedirect } = useAuth0();
  const { progress, progressLoading, progressError } = useProgress(
    isAuthenticated, 
    userInitialized, 
    getAccessTokenSilently, 
    user?.sub
  );

  // Show loading while Auth0 is initializing
  if (isLoading) {
    return <LoadingSpinner message="Loading profile..." fullScreen={true} />;
  }

  // Redirect to login if not authenticated
  if (!isAuthenticated) {
    loginWithRedirect();
    return <LoadingSpinner message="Redirecting to Sign In..." fullScreen={true} />;
  }

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      <Navbar />
      <div className="flex-1 p-2.5 w-full">
        <div className="bg-white rounded-lg shadow-sm border p-8">
          <div className="text-center mb-8">
            <h1 className="text-2xl font-semibold text-gray-900 mb-2">
              Welcome, {user.name || user.email}!
            </h1>
            <p className="text-gray-600">{user.email}</p>
          </div>

          <div className="space-y-6">
            <div>
              <h2 className="text-lg font-medium text-gray-900 mb-4">Profile Information</h2>
              <div className="space-y-3">
                <div>
                  <label className="block text-sm font-medium text-gray-700">Name</label>
                  <p className="mt-1 text-sm text-gray-900">{user.name || 'Not provided'}</p>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700">Email</label>
                  <p className="mt-1 text-sm text-gray-900">{user.email}</p>
                </div>
              </div>
            </div>

            <div>
              <h2 className="text-lg font-medium text-gray-900 mb-4">Progress by Category</h2>
              {progressLoading ? (
                <div className="flex items-center justify-center py-8">
                  <LoadingSpinner message="Loading progress..." />
                </div>
              ) : progressError ? (
                <div className="text-center py-4">
                  <p className="text-sm text-red-600">{progressError}</p>
                </div>
              ) : progress.length === 0 ? (
                <div className="text-center py-4">
                  <p className="text-sm text-gray-600">No progress data available</p>
                </div>
              ) : (
                <div className="space-y-3">
                  {progress.map((category, index) => (
                    <div key={index} className="bg-gray-50 rounded-lg p-4">
                      <div className="flex justify-between items-center mb-2">
                        <h3 className="font-medium text-gray-900">{category.category}</h3>
                        <span className="text-sm text-gray-600">
                          {category.completed} / {category.total}
                        </span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-2">
                        <div 
                          className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                          style={{ width: `${category.percentage}%` }}
                        ></div>
                      </div>
                      <p className="text-xs text-gray-500 mt-1">
                        {category.percentage}% complete
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </div>

            <div className="pt-6 border-t border-gray-200 flex justify-center">
              <button
                onClick={() => logout({ 
                  logoutParams: { 
                    returnTo: window.location.origin 
                  } 
                })}
                className="w-1/3 bg-red-600 text-white px-4 py-2 rounded-lg font-medium text-sm hover:bg-red-700 transition-colors duration-200 flex items-center justify-center gap-2"
              >
                <IoLogOutOutline className="w-4 h-4" />
                Sign Out
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default profilePage;