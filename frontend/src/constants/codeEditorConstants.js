/**
 * Code Editor Configuration Constants
 * 
 * UI timing delays, editor settings, and language options for the Monaco code editor.
 * Centralized configuration prevents magic numbers and enables easy customization.
 */

// Loading delay to prevent UI flashing for quick API responses (in milliseconds)
export const LOADING_DELAY_MS = 500;

// Default programming language when editor first loads
export const DEFAULT_LANGUAGE = 'python';

// Supported programming languages for the code editor
// Maps Monaco editor language identifiers to user-friendly labels
export const SUPPORTED_LANGUAGES = [
  { value: 'python', label: 'Python' },
  { value: 'java', label: 'Java' },
  { value: 'cpp', label: 'C++' },
  { value: 'javascript', label: 'JavaScript' }
];

// Monaco Editor configuration options
// Optimized for coding interview practice with clean, distraction-free interface
export const EDITOR_CONFIG = {
  fontSize: 14,                    // Readable font size for code
  tabSize: 4,                      // Standard indentation size
  lineNumbers: 'on',               // Show line numbers for debugging
  minimap: { enabled: false }      // Disable minimap to save space
};