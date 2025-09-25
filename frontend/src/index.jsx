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
import App from "./App";
import "./index.css";

const rootElement = document.getElementById("root"); // Find the root DOM element from index.html

if (rootElement) {
  const reactRoot = createRoot(rootElement); // Create React 18 root for improved performance and concurrent features
  reactRoot.render(<App />); // Render the main App component
} else {
  console.error("Root element not found. No div with id='root' in index.html"); // Error handling: log if root element is not found
}
