const { query } = require('../config/database');

/**
 * Problem Service
 * Handles all problem-related business logic and database operations
 */

const getRandomProblem = async () => {
  try {
    const result = await query('SELECT * FROM problems ORDER BY RANDOM() LIMIT 1', []);
    return result.rows[0];
  } catch (error) {
    console.error('Error fetching random problem:', error);
    throw error;
  }
};

const getUncompletedRandomProblem = async (userId) => {
  try {
    const result = await query('SELECT * FROM problems WHERE id NOT IN (SELECT problem_id FROM user_completions WHERE user_id = $1)', [userId]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching uncompleted problems:', error);
    throw error;
  }
};

const getUncompletedRandomProblemByCategory = async (category) => {
  try {
    const result = await query('SELECT * FROM problems WHERE category = $1 ORDER BY leetcode_problem_id LIMIT 1', [category]);
    return result.rows[0];
  } catch (error) {
    console.error('Error fetching new problem by category:', error);
    throw error;
  }
};

const getProblemById = async (id) => {
  try {
    const result = await query('SELECT * FROM problems WHERE id = $1', [id]);
    return result.rows[0];
  } catch (error) {
    console.error('Error fetching problem by ID:', error);
    throw error;
  }
};

const getProblemBySlug = async (slug) => {
  try {
    const result = await query('SELECT * FROM problems WHERE slug = $1', [slug]);
    return result.rows[0];
  } catch (error) {
    console.error('Error fetching problem by slug:', error);
    throw error;
  }
};

const getProblemsByCategory = async (category) => {
  try {
    const result = await query('SELECT * FROM problems WHERE category = $1 ORDER BY leetcode_problem_id', [category]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching problems by category:', error);
    throw error;
  }
};

const getProblemsByDifficulty = async (difficulty) => {
  try {
    const result = await query('SELECT * FROM problems WHERE difficulty = $1 ORDER BY leetcode_problem_id', [difficulty]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching problems by difficulty:', error);
    throw error;
  }
};

module.exports = {
  getRandomProblem,
  getUncompletedRandomProblem,
  getUncompletedRandomProblemByCategory,
  getProblemById,
  getProblemBySlug,
  getProblemsByCategory,
  getProblemsByDifficulty
};
