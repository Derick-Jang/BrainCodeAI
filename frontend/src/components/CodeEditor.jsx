/**
 * CodeEditor Component
 * 
 * A professional code editor interface with line numbers, language selection,
 * and syntax highlighting styling. Provides a clean environment for users
 * to write and edit their coding solutions.
 * 
 * @param {string} code - Current code content in the editor
 * @param {Function} setCode - Callback function to update the code state
 */

import React from 'react';
import { IoChevronDown } from 'react-icons/io5';

const CodeEditor = ({ code, setCode }) => {
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
          <select className="appearance-none bg-gray-50 border border-gray-200 text-gray-700 py-1.5 px-3 pr-8 rounded-md text-sm font-medium" defaultValue="python">
            <option value="python">Python</option>
            <option value="javascript">JavaScript</option>
            <option value="java">Java</option>
            <option value="cpp">C++</option>
          </select>
          {/* Custom dropdown arrow icon */}
          <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-400">
            <IoChevronDown className="h-4 w-4" />
          </div>
        </div>
      </div>
      {/* Main Editor Area */}
      <div className="flex-1 flex flex-col bg-white"> 
        <div className="flex-1 flex">
          {/* Line Numbers Gutter */}
          <div className="bg-gray-50 px-2 py-2 border-r border-gray-200 text-xs text-gray-400 font-mono select-none">
            {Array.from({ length: 30 }, (_, i) => (
              <div key={i} className="leading-6">{i + 1}</div>
            ))}
          </div>
          {/* Code Input Area */}
          <textarea
            value={code}
            onChange={(e) => setCode(e.target.value)}
            placeholder="Insert your code here..."
            className="flex-1 w-full min-h-[300px] p-2 border-0 resize-none outline-none font-mono text-sm leading-6 bg-white text-gray-900 placeholder-gray-400"
            spellCheck={false}
          />
        </div>
      </div>
    </div>
  );
};

export default CodeEditor;