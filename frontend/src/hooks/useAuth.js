import { useEffect, useState } from 'react';
import { useAuth0 } from '@auth0/auth0-react';
import { postRegisterUser } from '../services/api';

/**
 * Custom hook for handling user authentication and backend registration
 * 
 * Automatically registers authenticated users in the backend database to enable
 * progress tracking and problem completion features. This is a one-time process
 * that happens after successful Auth0 authentication.
 * 
 * @returns {Object} Authentication state and utilities
 * @returns {boolean} isAuthenticated - Whether user is logged in via Auth0
 * @returns {boolean} isLoading - Whether Auth0 is still initializing
 * @returns {Object} user - Auth0 user object with profile information
 * @returns {boolean} userInitialized - Whether user has been registered in backend
 * @returns {string|null} userInitializationError - Error message if registration failed
 * @returns {Function} getAccessTokenSilently - Function to get fresh access tokens
 */
const useAuth = () => {
  const { isAuthenticated, isLoading, getAccessTokenSilently, user } = useAuth0();
  const [userInitialized, setUserInitialized] = useState(false);
  const [userInitializationError, setUserInitializationError] = useState(null);

  useEffect(() => {
    // Only register user once when they become authenticated
    if (isAuthenticated && !userInitialized) {
      const initializeUser = async () => {
        try {
          setUserInitializationError(null);
          const token = await getAccessTokenSilently();
          // Register user in backend database for progress tracking
          await postRegisterUser(token, user.sub, user.name, user.email);
          setUserInitialized(true);
        } catch (error) {
          console.error('Error initializing user:', error);
          setUserInitializationError('Failed to initialize user');
        }
      };
      initializeUser();
    }
  }, [isAuthenticated, userInitialized]);

  return {
    isAuthenticated,
    isLoading,
    user,
    userInitialized,
    userInitializationError,
    getAccessTokenSilently
  };
};

export default useAuth;