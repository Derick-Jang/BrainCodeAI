/**
 * Application Entry Point
 * 
 * Initializes React 18 root and renders the main App component with Auth0 authentication.
 */

import React from "react";
import { createRoot } from "react-dom/client";
import { Auth0Provider } from "@auth0/auth0-react";
import App from "./app";
import "./index.css";

const rootElement = document.getElementById("root");

if (rootElement) {
  const reactRoot = createRoot(rootElement);
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
  );
} else {
  console.error("Root element not found. No div with id='root' in index.html");
}
