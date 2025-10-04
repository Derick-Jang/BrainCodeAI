// Import required modules
const fs = require('fs');
const path = require('path');
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

// Initalizes and populates database
const initializeDatabase = async () => {
    try {
      // Read the SQL script from schema.sql
      const filePath = path.join(__dirname, 'schema.sql');
      const sql = fs.readFileSync(filePath, 'utf8');
  
      // Run all statements in a single transaction
      await pool.query('BEGIN');
      await pool.query(sql);
      await pool.query('COMMIT');
  
      console.log('Database successfully initialized and populated');
    } catch (error) {
      await pool.query('ROLLBACK'); // undo changes if any error occurs
      console.error('Error initializing and populating database:', error);
      throw error;
    }
  };

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
    initializeDatabase
}