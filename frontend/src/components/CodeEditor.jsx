/**
 * CodeEditor Component
 * 
 * A professional code editor interface using Monaco Editor with line numbers, 
 * language selection, and syntax highlighting. Provides a clean environment for users
 * to write and edit their coding solutions.
 * 
 * @param {string} code - Current code content in the editor
 * @param {Function} setCode - Callback function to update the code state
 * @param {string} selectedLanguage - Currently selected programming language
 * @param {Function} setSelectedLanguage - Callback function to update the selected language
 */

import React, { useCallback, useMemo } from 'react';
import { Editor } from '@monaco-editor/react';
import { IoChevronDown } from 'react-icons/io5';

const CodeEditor = ({ code, setCode, selectedLanguage, setSelectedLanguage }) => {
  const languageOptions = [
    { value: 'python', label: 'Python' },
    { value: 'java', label: 'Java' },
    { value: 'cpp', label: 'C++' },
    { value: 'javascript', label: 'JavaScript' }
  ];

  // Memoize the change handler to prevent unnecessary re-renders
  const handleEditorChange = useCallback((value) => {
    setCode(value || '');
  }, [setCode]);

  const handleLanguageChange = useCallback((e) => {
    setSelectedLanguage(e.target.value);
  }, [setSelectedLanguage]);

  // Memoize editor options to prevent recreation on every render
  const editorOptions = useMemo(() => ({
    // Essential for basic functionality
    automaticLayout: true,
    fontSize: 14,
    lineNumbers: 'on',
    tabSize: 4,
    insertSpaces: true,
    readOnly: false,
    minimap: { enabled: false },
  }), []);

  return (
    <div className="flex flex-col h-full">
      {/* Editor Header: Title and Language Selector */}
      <div className="flex justify-between items-center px-2 py-1.5 border-b border-gray-200 bg-white">
        {/* Editor title with code brackets icon */}
        <div className="flex items-center gap-2">
          <span className="text-sm font-medium text-gray-700">&lt; &gt; Code Editor</span>
        </div>
        {/* Programming Language Selector */}
        <div className="relative">
          <select 
            className="appearance-none bg-gray-50 border border-gray-200 text-gray-700 py-1.5 px-3 pr-8 rounded-md text-sm font-medium"
            value={selectedLanguage}
            onChange={handleLanguageChange}
          >
            {languageOptions.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
          {/* Custom dropdown arrow icon */}
          <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-400">
            <IoChevronDown className="h-4 w-4" />
          </div>
        </div>
      </div>
      
      {/* Monaco Editor */}
      <div className="flex-1 bg-white overflow-auto">
        <Editor
          height="100%"
          language={selectedLanguage}
          value={code}
          onChange={handleEditorChange}
          theme="vs"
          options={editorOptions}
          loading={<div className="flex items-center justify-center h-full">Loading editor...</div>}
        />
      </div>
    </div>
  );
};

export default CodeEditor;