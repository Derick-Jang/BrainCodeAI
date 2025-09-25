# BrainCodeAI - Interview Prep Platform

A coding interview preparation platform that provides AI-powered feedback on coding solutions. This MVP focuses on problem display, code submission, and AI feedback generation.

## Core Flow
1. **Page loads** → renders one hardcoded problem (Two Sum) with test cases and constraints
2. **User types code** in the code editor
3. **User clicks "Submit"** → sends code + problem to OpenAI API
4. **Display AI response** in the AI Feedback section

## Tech Stack

### Frontend
- **React + Vite** - Modern React development
- **Tailwind CSS + PostCSS** - Utility-first styling
- **Axios** - HTTP client for API calls
- **React Icons** - Icon components

### Backend
- **Express.js/Node.js** - Web server framework
- **OpenAI JS SDK** - AI feedback generation
- **CORS middleware** - Cross-origin resource sharing
- **Express Rate Limit** - API rate limiting
- **Joi** - Input validation

## Project Structure
```
BrainCodeAI/
├── frontend/          # React + Vite application
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── services/      # API service layer
│   │   └── App.jsx        # Main application
│   └── package.json
├── backend/           # Express.js server
│   ├── app.js         # Main server file
│   └── package.json
└── README.md
```

## Getting Started

### Prerequisites
- Node.js (v18 or higher)
- OpenAI API key

### Backend Setup
1. Navigate to backend directory:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Create environment file:
   ```bash
   # Copy the example environment file
   cp .env.example .env
   
   # Edit the .env file with your actual OpenAI API key
   # Get your API key from: https://platform.openai.com/api-keys
   ```

4. Start the server:
   ```bash
   npm run dev
   ```
   Server will run on `http://localhost:4000`

### Frontend Setup
1. Navigate to frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Configure environment (optional):
   ```bash
   # For development (uses default localhost:4000)
   cp .env.development.example .env.development
   
   # For production (update with your production API URL)
   cp .env.production.example .env.production
   ```

4. Start the development server:
   ```bash
   npm run dev
   ```
   Frontend will run on `http://localhost:3000`

## API Endpoints

- `GET /api/health` - Health check endpoint
- `GET /api/problem` - Fetch the current problem (Two Sum)
- `POST /api/submit` - Submit code for AI feedback

## Features

- **Problem Display**: Shows problem description, examples, and constraints
- **Code Editor**: Simple textarea-based code editor with line numbers
- **AI Feedback**: OpenAI-powered code analysis and suggestions
- **Rate Limiting**: Prevents API abuse
- **Error Handling**: Graceful error handling for failed requests

## Development

- Backend uses nodemon for auto-restart during development
- Frontend uses Vite for fast development and hot reloading
- CORS is configured to allow frontend-backend communication
