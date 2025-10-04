/**
 * Application Entry Point
 * 
 * This file serves as the main entry point for the React application.
 * It initializes the React root, imports global styles, and renders
 * the main App component into the DOM.
 * 
 */

import React from "react";
import { createRoot } from "react-dom/client";
import { Auth0Provider } from "@auth0/auth0-react";
import App from "./App";
import "./index.css";

const rootElement = document.getElementById("root"); // Find the root DOM element from index.html

if (rootElement) {
  const reactRoot = createRoot(rootElement); // Create React 18 root for improved performance and concurrent features
  reactRoot.render(
    <Auth0Provider
      domain={import.meta.env.VITE_AUTH0_DOMAIN}
      clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
      authorizationParams={{
        redirect_uri: window.location.origin,
        audience: import.meta.env.VITE_AUTH0_AUDIENCE,
        scope: 'openid profile email'
      }}
    >
      <App />
    </Auth0Provider>
  ); // Render the main App component wrapped with Auth0Provider
} else {
  console.error("Root element not found. No div with id='root' in index.html"); // Error handling: log if root element is not found
}
