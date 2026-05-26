import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { withAuthenticationRequired } from '@auth0/auth0-react';
import HomePage from './pages/homePage';
import ProfilePage from './pages/profilePage';
import LoadingSpinner from './components/common/LoadingSpinner';
import useAuth from './hooks/useAuth';
import ErrorBoundary from './components/common/ErrorBoundary';

/**
 * Protected version of ProfilePage that requires authentication
 * Redirects to Auth0 login if user is not authenticated
 */
const ProtectedProfilePage = withAuthenticationRequired(ProfilePage, {
  onRedirecting: () => <LoadingSpinner message="Redirecting to sign in..." fullScreen={true} />,
});

/**
 * Main App component that handles routing and authentication state
 * Wraps all routes in ErrorBoundary for error handling
 */
function App() {
  const { isLoading } = useAuth();

  // Show loading spinner while Auth0 is initializing
  if (isLoading) {
    return <LoadingSpinner message="Initializing..." fullScreen={true} />;
  }
  
  return (
    <ErrorBoundary>
      <Router>
        <div className="min-h-screen bg-gray-100 flex flex-col">
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/profile" element={<ProtectedProfilePage />} />
          </Routes>
        </div>
      </Router>
    </ErrorBoundary>
  );
}

export default App;