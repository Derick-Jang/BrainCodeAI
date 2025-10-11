const { query } = require('../config/database');

const getRandomProblem = async (req, res, next) => {
  try {
    const result = await query('SELECT * FROM problems ORDER BY RANDOM() LIMIT 1', []);
    const problem = result.rows[0];
    
    res.json({
      success: true,
      problemData: problem
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getRandomProblem
};