/**
 * Problem Component
 * 
 * Displays coding problem details including title, difficulty, description, 
 * examples, and constraints in a clean, readable format similar to LeetCode.
 * 
 * @param {Object} problem - The problem object containing all problem data
 * @param {string} problem.title - The problem title (e.g., "Two Sum")
 * @param {string} problem.leetcode_problem_id - The problem number (e.g., "1")
 * @param {string} problem.difficulty - Problem difficulty: "Easy", "Medium", or "Hard"
 * @param {string} problem.description - Detailed problem description
 * @param {Array} problem.examples - Array of example objects with input/output/explanation
 * @param {Array} problem.constraints - Array of constraint strings
 * @param {string} problem.category - The problem category (e.g., "Arrays-&-Hashing")
 */

import React from 'react';

const Problem = ({ problem, onNextProblem }) => {
  return (
    <div className="p-3 h-full overflow-y-auto">
      {/* Problem Header: Number, Title, and Difficulty Badge */}
      <div className="flex items-center justify-between mb-2.5">
        <div className="flex items-center gap-3">
          <span className="text-lg font-medium text-gray-600">{problem.leetcode_problem_id}.</span> {/* Problem number*/}
          <h2 className="text-xl font-medium text-gray-900">{problem.title}</h2> {/* Problem title */}
          <span className="px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">{problem.difficulty}</span> {/* Difficulty badge - hardcoded Easy styling */}
        </div>
        {/* Next Question Button */}
        <button
          onClick={onNextProblem}
          className="px-3 py-2 bg-green-400 hover:bg-green-300 text-white text-sm font-medium rounded-lg transition-colors duration-200 flex items-center gap-2"
        >
          Next Problem →
        </button>
      </div>
      {/* Problem Description */}
      <div className="mb-3">
        <p className="leading-7 text-gray-700">{problem.description}</p>
      </div>
      {/* Examples Section */}
      <div className="mb-3">
        <h3 className="text-base font-semibold text-gray-900 mb-3">Examples</h3> {/* Examples header */}
        {/* Render each example */}
        {problem.examples.map((example, index) => (
          <div key={index} className="bg-gray-50 border border-gray-200 rounded-lg p-2 mb-2"> {/* Example container */}
            {/* Example number */}
            <div className="mb-2">
              <span className="text-sm font-semibold text-gray-700">Example {index + 1}:</span>
            </div>
            {/* Input*/}
            <div className="mb-2 text-sm"> 
              <strong className="text-gray-900">Input: </strong> 
              <code className="bg-gray-200 px-2 py-1 rounded text-xs font-mono text-gray-800">{example.input}</code>
            </div>
            {/* Output */}
            <div className="mb-2 text-sm">
              <strong className="text-gray-900">Output: </strong> 
              <code className="bg-gray-200 px-2 py-1 rounded text-xs font-mono text-gray-800">{example.output}</code>
            </div>
            {/* Optional explanation */}
            {example.explanation && (
              <div className="mb-0 text-sm">
                <strong className="text-gray-900">Explanation: </strong>
                <span className="text-gray-700">{example.explanation}</span>
              </div>
            )}
          </div>
        ))}
      </div>
      {/* Constraints Section */}
      <div>
        <h3 className="text-lg font-semibold text-gray-800 mb-3">Constraints:</h3>
        <ul className="m-0 pl-5 text-gray-600 list-disc"> {/* Bulleted list of constraints */}
          {problem.constraints.map((constraint, index) => (
            <li key={index} className="mb-1 text-sm">{constraint}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default Problem;