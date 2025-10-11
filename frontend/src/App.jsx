import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { withAuthenticationRequired } from '@auth0/auth0-react';
import HomePage from './pages/HomePage';
import ProfilePage from './pages/ProfilePage';
import LoadingSpinner from './components/common/LoadingSpinner';
import { useAuth } from './hooks/useAuth';
import ErrorBoundary from './components/common/ErrorBoundary';

// Create a protected version of ProfilePage
const ProtectedProfilePage = withAuthenticationRequired(ProfilePage, {
  onRedirecting: () => <LoadingSpinner message="Redirecting to sign in..." fullScreen={true} />,
});

function App() {
  const { isLoading, userInitialized } = useAuth();

  if (isLoading) {
    return <LoadingSpinner message="Initializing..." fullScreen={true} />;
  }
  
  return (
    <ErrorBoundary>
      <Router>
        <div className="min-h-screen bg-gray-100 flex flex-col">
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/profile" element={<ProtectedProfilePage userInitialized={userInitialized} />} />
          </Routes>
        </div>
      </Router>
    </ErrorBoundary>
  );
}

export default App;