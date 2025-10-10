/**
 * UI Configuration Constants
 * Timing delays, size constraints, and other UI-related values
 */

// Loading delay to prevent UI flashing (in milliseconds)
export const LOADING_DELAY_MS = 500;

// Default programming language for code editor
export const DEFAULT_LANGUAGE = 'python';

// Supported programming languages
export const SUPPORTED_LANGUAGES = [
  { value: 'python', label: 'Python' },
  { value: 'java', label: 'Java' },
  { value: 'cpp', label: 'C++' },
  { value: 'javascript', label: 'JavaScript' }
];

// Editor configuration
export const EDITOR_CONFIG = {
  fontSize: 14,
  tabSize: 4,
  lineNumbers: 'on',
  minimap: { enabled: false }
};