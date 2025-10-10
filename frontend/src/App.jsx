import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './components/layout/Navbar';
import HomePage from './pages/HomePage';
import ProfilePage from './pages/ProfilePage';
import LoadingSpinner from './components/common/LoadingSpinner';
import { useAuth } from './hooks/useAuth';
import ErrorBoundary from './components/common/ErrorBoundary';

function App() {
  const { isLoading, userInitialized } = useAuth();

  if (isLoading) {
    return <LoadingSpinner message="Initializing..." />;
  }
  
  return (
    <ErrorBoundary>
      <Router>
        <div className="min-h-screen bg-gray-100 flex flex-col">
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/profile" element={<ProfilePage userInitialized={userInitialized} />} />
          </Routes>
        </div>
      </Router>
    </ErrorBoundary>
  );
}

export default App;