import { useEffect, useState } from 'react';
import { useAuth0 } from '@auth0/auth0-react';
import { registerUser } from '../services/api';

/**
 * Custom hook for handling user authentication and initialization
 * Registers user in backend database when authenticated
 */
export const useAuth = () => {
  const { isAuthenticated, isLoading, getAccessTokenSilently, user } = useAuth0();
  const [userInitialized, setUserInitialized] = useState(false);
  const [userInitializationError, setUserInitializationError] = useState(null);

  useEffect(() => {
    if (isAuthenticated && !userInitialized) {
      const initializeUser = async () => {
        try {
          setUserInitializationError(null);
          const token = await getAccessTokenSilently();
          await registerUser(token, user.sub, user.name, user.email);
          setUserInitialized(true);
        } catch (error) {
          console.error('Error initializing user:', error);
          setUserInitializationError('Failed to initialize user');
        }
      };
      initializeUser();
    }
  }, [isAuthenticated, userInitialized, getAccessTokenSilently, user]);

  return {
    isAuthenticated,
    isLoading,
    user,
    userInitialized,
    userInitializationError,
    getAccessTokenSilently
  };
};