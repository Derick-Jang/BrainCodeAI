const { query } = require('../config/database');

const ensureUserExists = async (auth0Id, email, name) => {
  const existingUser = await query(
    'SELECT id FROM users WHERE auth0_id = $1',
    [auth0Id]
  );

  if (existingUser.rows.length > 0) {
    return existingUser.rows[0].id;
  }

  const newUser = await query(
    'INSERT INTO users (auth0_id, email, name) VALUES ($1, $2, $3) RETURNING id',
    [auth0Id, email, name || 'User']
  );

  return newUser.rows[0].id;
};

const getUserIdByAuth0Id = async (auth0Id) => {
  const result = await query(
    'SELECT id FROM users WHERE auth0_id = $1',
    [auth0Id]
  );

  if (result.rows.length === 0) {
    throw new Error('User not found');
  }

  return result.rows[0].id;
};

const getUserProgress = async (userId) => {
  const progressQuery = `
    SELECT 
      p.category,
      COUNT(DISTINCT p.id) as total_count,
      COUNT(DISTINCT uc.problem_id) as completed_count
    FROM problems p
    LEFT JOIN user_completions uc ON p.id = uc.problem_id AND uc.user_id = $1
    GROUP BY p.category
    ORDER BY p.category
  `;
  
  const result = await query(progressQuery, [userId]);
  
  return result.rows.map(row => ({
    category: row.category,
    completed: parseInt(row.completed_count) || 0,
    total: parseInt(row.total_count) || 0,
    percentage: row.total_count > 0 
      ? Math.round((parseInt(row.completed_count) / parseInt(row.total_count)) * 100)
      : 0
  }));
};

const markProblemComplete = async (userId, problemId, category) => {
  const result = await query(
    `INSERT INTO user_completions (user_id, problem_id, category, attempts)
     VALUES ($1, $2, $3, 1)
     ON CONFLICT (user_id, problem_id) 
     DO UPDATE SET 
       attempts = user_completions.attempts + 1
     RETURNING *`,
    [userId, problemId, category]
  );

  return result.rows[0];
};

module.exports = {
  ensureUserExists,
  getUserIdByAuth0Id,
  getUserProgress,
  markProblemComplete
};