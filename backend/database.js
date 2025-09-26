// Import required modules
const fs = require('fs');
const { Pool } = require('pg');
require('dotenv').config();

// Create PostgreSQL connection pool
const pool = new Pool({
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'braincodeai_db',
  max: 20,
});


// Test the connection and logs error status
pool.on('connect', () => {
    console.log('Connected to PostgreSQL database');
  });
pool.on('error', (err) => {
    console.error('Unexpected error on idle client: ', err);
    process.exit(-1);
});

// Helper function to run queries with SQL injection protection
const query = async (text, params) => {
    try {
        const res = await pool.query(text, params);
        return res;
    } catch (error) {
        console.error('Database query failed:', error);
        throw error;
    }
};

// Helper function to get a client from the pool. Reminder: Remember to release the client when done
const getClient = async () => {
  return await pool.connect();
};

// Export functions
module.exports = {
    pool,
    query,
    getClient,
}