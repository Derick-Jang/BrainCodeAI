-- You can run this SQL script to create the database and tables
-- Use the command psql -d insert_db_name -f schema.sql

-- Create Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,                          -- Unique user ID
    auth0_id VARCHAR(255) UNIQUE NOT NULL,         -- Auth0 user ID (e.g., "auth0|123456789")
    email VARCHAR(255) UNIQUE NOT NULL,            -- Email for login/reset
    name VARCHAR(255) NOT NULL                     -- User's name
);

-- Create Problems table
CREATE TABLE IF NOT EXISTS problems (
    id SERIAL PRIMARY KEY,                          -- Unique problem ID
    leetcode_problem_id INT UNIQUE NOT NULL,                            -- Problem number in list
    slug VARCHAR(100) UNIQUE NOT NULL,             -- URL-friendly identifier (e.g., "two-sum")
    title VARCHAR(255) NOT NULL,                    -- Problem title
    difficulty VARCHAR(20) NOT NULL CHECK (difficulty IN ('Easy', 'Medium', 'Hard')), -- Difficulty level
    description TEXT NOT NULL,                      -- Full problem description
    constraints TEXT[],                             -- Array of constraints
    examples JSONB NOT NULL,                        -- JSON array of example objects
    category VARCHAR(100) NOT NULL                  -- Problem pattern/category (e.g., "Array")
);

-- Create User Completions table
CREATE TABLE IF NOT EXISTS user_completions (
    id SERIAL PRIMARY KEY,                           -- Unique completion ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,     -- Foreign key to users
    problem_id INTEGER REFERENCES problems(id) ON DELETE CASCADE, -- Foreign key to problems
    category VARCHAR(100) NOT NULL,                  -- Store category at completion
    attempts INTEGER DEFAULT 1,                      -- Number of attempts before completion
    UNIQUE(user_id, problem_id)                      -- Prevent duplicate completions
);

-- Indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_problems_category ON problems(category);
CREATE INDEX IF NOT EXISTS idx_user_completions_user ON user_completions(user_id);
CREATE INDEX IF NOT EXISTS idx_user_completions_problem ON user_completions(problem_id);