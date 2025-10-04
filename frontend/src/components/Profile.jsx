/**
 * Profile Component
 * 
 * Displays user profile information, progress tracking, and provides sign out functionality.
 * Shows user details from Auth0, progress by category, and allows users to sign out.
 */

import React, { useState, useEffect } from 'react';
import { useAuth0 } from '@auth0/auth0-react';
import { IoLogOutOutline } from 'react-icons/io5';
import { getUserProgress, registerUser } from '../services/api.js';

const Profile = () => {
  const { user, logout, isAuthenticated, isLoading, getAccessTokenSilently, loginWithRedirect } = useAuth0();
  const [progress, setProgress] = useState([]);
  const [progressLoading, setProgressLoading] = useState(false);
  const [progressError, setProgressError] = useState(null);

  // Register user and fetch progress when component mounts
  useEffect(() => {
    if (isAuthenticated) {
      const initializeUser = async () => {
        try {
          setProgressLoading(true);
          setProgressError(null);
          
          const token = await getAccessTokenSilently();
          // First, ensure user is registered in database
          await registerUser(token, user.sub, user.name, user.email);
          
          // Then fetch their progress
          // const progressData = await getUserProgress();
          setProgress([]);
        } catch (error) {
          console.error('Error initializing user:', error);
          setProgressError('Failed to load progress');
        } finally {
          setProgressLoading(false);
        }
      };
      initializeUser();
    }
  }, [isAuthenticated]);

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gray-100 flex items-center justify-center">
        <div className="text-center">
          <div className="w-8 h-8 border-4 border-gray-300 border-t-gray-900 rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Loading profile...</p>
        </div>
      </div>
    );
  }

  // If user is not authenticated, show loading or redirect message
  if (!isAuthenticated) {
    return (
      <div className="min-h-screen bg-gray-100 flex items-center justify-center">
        <div className="text-center">
          <div className="w-8 h-8 border-4 border-gray-300 border-t-gray-900 rounded-full animate-spin mx-auto mb-4"></div>
          <h1 className="text-2xl font-semibold text-gray-900 mb-4">Redirecting to Sign In...</h1>
          <p className="text-gray-600">Please complete the authentication process.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-100">
      <div className="max-w-2xl mx-auto py-8 px-4">
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
                <div className="text-center py-4">
                  <div className="w-6 h-6 border-2 border-gray-300 border-t-gray-900 rounded-full animate-spin mx-auto mb-2"></div>
                  <p className="text-sm text-gray-600">Loading progress...</p>
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

            <div className="pt-6 border-t border-gray-200">
              <button
                onClick={() => logout({ 
                  logoutParams: { 
                    returnTo: window.location.origin 
                  } 
                })}
                className="w-full bg-red-600 text-white px-4 py-2 rounded-lg font-medium text-sm hover:bg-red-700 transition-colors duration-200 flex items-center justify-center gap-2"
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

export default Profile;
