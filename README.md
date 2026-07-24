# BrainCodeAI

Link: https://braincode-ai.vercel.app

A comprehensive coding interview preparation platform that provides AI-powered feedback on coding solutions. Features user authentication, progress tracking, multiple problem categories, and an advanced code editor with real-time AI feedback.

## Core Features
1. **User Authentication** - Auth0 integration for secure user management
2. **Problem Database** - 17+ problem categories with 75+ coding challenges
3. **Advanced Code Editor** - Monaco Editor with syntax highlighting and multiple language support
4. **AI-Powered Feedback** - OpenAI integration for intelligent code analysis and suggestions
5. **Progress Tracking** - User completion tracking and statistics
6. **Hint System** - AI-generated hints to help users when stuck
7. **Responsive Design** - Modern UI with Tailwind CSS
8. **Problem Recommendation** - Suggests new problems tailored by category or difficulty (Optional) 

## Tech Stack

### Frontend
- **React + Vite** - Modern React development with hot reloading
- **React Router DOM** - Client-side routing
- **React Hooks** - State management
- **Auth0 React SDK** - Authentication and user management
- **Monaco Editor** - Advanced code editor with syntax highlighting
- **Tailwind CSS** - Utility-first styling
- **Axios** - HTTP client for API calls

### Backend
- **Express.js/Node.js** - Web server framework
- **PostgreSQL** - Relational database for users, problems, and progress
- **Auth0 JWT** - Secure authentication middleware
- **OpenAI JS SDK** - AI feedback generation
- **CORS middleware** - Cross-origin resource sharing
- **Express Rate Limit** - API rate limiting

## Project Structure
```
BrainCodeAI/
├── frontend/                    # React + Vite application
│   ├── src/
│   │   ├── components/          # React components
│   │   │   ├── common/          # Reusable UI components
│   │   │   ├── content/         # Content display components
│   │   │   ├── forms/           # Form components (CodeEditor)
│   │   │   └── layout/          # Layout components (Navbar)
│   │   ├── pages/               # Page components
│   │   ├── hooks/               # Custom React hooks
│   │   ├── services/            # API service layer
│   │   ├── constants/           # Application constants
│   │   └── app.jsx              # Main application with routing
│   ├── index.html               # HTML template
│   └── package.json
├── backend/                     # Express.js server
│   ├── src/
│   │   ├── controllers/         # Route controllers
│   │   ├── services/            # Business logic services
│   │   ├── middleware/          # Custom middleware
│   │   ├── routes/              # API route definitions
│   │   ├── config/              # Configuration files
│   │   ├── database/            # Database schema and problem data
│   │   │   └── problems/        # Problem category SQL files
│   │   ├── utils/               # Utility functions
│   │   └── server.js            # Main server file
│   └── package.json
└── README.md
```

## API Endpoints

### Health & Status
- `GET /api/health` - Health check endpoint

### Problems
- `GET /api/problems/random` - Fetch a random coding problem

### Code Submission & AI
- `POST /api/code/submissions` - Submit code for AI feedback
- `POST /api/code/hints` - Request AI-generated hint for current problem

### User Management
- `POST /api/users` - Register new user (Auth0 integration)
- `POST /api/users/completions` - Mark problem as completed
- `GET /api/users/progress` - Get user progress statistics

## Features

### User Experience
- **User Authentication**: Secure login/logout with Auth0 integration
- **Progress Tracking**: Track completed problems and user statistics
- **Profile Management**: User profile page with completion history
- **Responsive Design**: Mobile-friendly interface with Tailwind CSS

### Problem Management
- **Problem Database**: 17+ categories with 75+ coding challenges
- **Problem Categories**: Arrays & Hashing, Dynamic Programming, Graphs, Trees, and more
- **Difficulty Levels**: Easy, Medium, and Hard problems
- **Problem Navigation**: Easy switching between problems

### Code Editor
- **Monaco Editor**: Advanced code editor with syntax highlighting
- **Multi-Language Support**: JavaScript, Python, Java, C++, and more
- **Real-time Editing**: IntelliSense and auto-completion
- **Code Formatting**: Built-in code formatting capabilities

### AI Integration
- **AI Feedback**: OpenAI-powered code analysis and suggestions
- **Hint System**: AI-generated hints when users are stuck
- **Code Review**: Detailed analysis of code quality and efficiency
- **Learning Suggestions**: Recommendations for improvement

### System Features
- **Rate Limiting**: Prevents API abuse and ensures fair usage
- **Error Handling**: Comprehensive error handling and user feedback
- **Database Integration**: PostgreSQL for reliable data persistence
- **JWT Authentication**: Secure API access with JSON Web Tokens

## Problem Categories

The platform includes 17+ problem categories with comprehensive coding challenges:

- **Arrays & Hashing** - Two pointers, sliding window, prefix sums
- **Two Pointers** - Fast and slow pointers, meeting in the middle
- **Sliding Window** - Fixed and variable window techniques
- **Stack** - LIFO data structure problems
- **Binary Search** - Search algorithms and variations
- **Linked List** - Node manipulation and traversal
- **Trees** - Binary trees, BST, traversal algorithms
- **Tries** - Prefix trees and string matching
- **Backtracking** - Recursive problem solving
- **Heap/Priority Queue** - Min/max heap operations
- **Graphs** - BFS, DFS, shortest path algorithms
- **Advanced Graphs** - Topological sort, union-find
- **Dynamic Programming** - Memoization and tabulation
- **Greedy** - Greedy algorithm techniques
- **Intervals** - Merge intervals, scheduling
- **Math & Geometry** - Mathematical problem solving
- **Bit Manipulation** - Bitwise operations
