const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

const pool = new Pool({
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'braincodeai_db',
  max: 20,
});

pool.on('connect', () => {
  console.log('Connected to PostgreSQL database');
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle client:', err);
  process.exit(-1);
});

const initializeDatabase = async () => {
  try {
    const filePath = path.join(__dirname, '../database/schema.sql');
    const sql = fs.readFileSync(filePath, 'utf8');

    await pool.query('BEGIN');
    await pool.query(sql);
    await pool.query('COMMIT');

    console.log('Database successfully initialized and populated');
  } catch (error) {
    await pool.query('ROLLBACK');
    console.error('Error initializing database:', error);
    throw error;
  }
};

const query = async (text, params) => {
  try {
    const res = await pool.query(text, params);
    return res;
  } catch (error) {
    console.error('Database query failed:', error);
    throw error;
  }
};

const getClient = async () => {
  return await pool.connect();
};

module.exports = {
  pool,
  query,
  getClient,
  initializeDatabase
};