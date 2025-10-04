# Auth0 Setup Instructions

This application has been configured to use Auth0 for authentication. Follow these steps to complete the setup:

## Frontend Configuration

1. Create a `.env` file in the `frontend` directory with the following variables:

```env
VITE_AUTH0_DOMAIN=your-auth0-domain.auth0.com
VITE_AUTH0_CLIENT_ID=your-auth0-client-id
VITE_API_BASE_URL=http://localhost:4000
```

## Backend Configuration

1. Create a `.env` file in the `backend` directory with the following variables:

```env
AUTH0_DOMAIN=your-auth0-domain.auth0.com
AUTH0_AUDIENCE=your-auth0-api-identifier
OPENAI_API_KEY=your-openai-api-key
DATABASE_URL=your-postgresql-connection-string
FRONTEND_URL=http://localhost:3000
NODE_ENV=development
```

## Auth0 Dashboard Setup

1. **Create an Auth0 Application:**
   - Go to [Auth0 Dashboard](https://manage.auth0.com/)
   - Navigate to Applications > Applications
   - Click "Create Application"
   - Choose "Single Page Application"
   - Name it "BrainCodeAI Frontend"

2. **Configure Application Settings:**
   - **Allowed Callback URLs:** `http://localhost:3000`
   - **Allowed Logout URLs:** `http://localhost:3000`
   - **Allowed Web Origins:** `http://localhost:3000`
   - **Allowed Origins (CORS):** `http://localhost:3000`

3. **Create an Auth0 API:**
   - Go to Applications > APIs
   - Click "Create API"
   - Name: "BrainCodeAI API"
   - Identifier: `https://api.braincodeai.com` (or your preferred identifier)
   - Signing Algorithm: RS256

4. **Configure API Settings:**
   - Go to your API settings
   - Note the **Identifier** - this becomes your `AUTH0_AUDIENCE`
   - Enable "Allow Offline Access" if you want refresh tokens

## Database Setup

1. **Install PostgreSQL** if not already installed
2. **Create a database** for the application
3. **Run the schema:** `psql -d your_database_name -f backend/database/schema.sql`
4. **Update the DATABASE_URL** in your backend `.env` file

## Running the Application

1. **Install dependencies:**
   ```bash
   # Frontend
   cd frontend
   npm install
   
   # Backend
   cd backend
   npm install
   ```

2. **Start the backend:**
   ```bash
   cd backend
   npm run dev
   ```

3. **Start the frontend:**
   ```bash
   cd frontend
   npm run dev
   ```

## Features

- **Authentication:** Users can sign in/out using Auth0
- **Profile Page:** View user information and progress tracking
- **Progress Tracking:** Track completed problems by category
- **Protected Routes:** Profile page requires authentication
- **JWT Tokens:** Secure API communication with Auth0 JWT tokens

## Troubleshooting

- Make sure all environment variables are set correctly
- Check that Auth0 application settings match your local URLs
- Ensure the database is running and accessible
- Check browser console for any CORS or authentication errors
