/**
 * Application Entry Point
 * 
 * Initializes React 18 root and renders the main App component with Auth0 authentication.
 */

import React from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter, useNavigate } from "react-router-dom";
import { Auth0Provider } from "@auth0/auth0-react";
import App from "./App";
import "./index.css";

/**
 * Wraps Auth0Provider so post-login redirects use React Router navigation.
 */
function Auth0ProviderWithNavigate({ children }) {
  const navigate = useNavigate();

  return (
    <Auth0Provider
      domain={import.meta.env.VITE_AUTH0_DOMAIN}
      clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
      authorizationParams={{
        redirect_uri: window.location.origin,
        audience: import.meta.env.VITE_AUTH0_AUDIENCE,
        scope: 'openid profile email'
      }}
      onRedirectCallback={(appState) => {
        navigate(appState?.returnTo || '/', { replace: true });
      }}
    >
      {children}
    </Auth0Provider>
  );
}

const rootElement = document.getElementById("root");

if (rootElement) {
  const reactRoot = createRoot(rootElement);
  reactRoot.render(
    <BrowserRouter>
      <Auth0ProviderWithNavigate>
        <App />
      </Auth0ProviderWithNavigate>
    </BrowserRouter>
  );
} else {
  console.error("Root element not found. No div with id='root' in index.html");
}
