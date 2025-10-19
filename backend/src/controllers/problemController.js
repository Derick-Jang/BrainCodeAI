const { getRandomProblem: getRandomProblemService } = require('../services/problemService');

const getRandomProblem = async (req, res, next) => {
  try {
    const problem = await getRandomProblemService();
    
    res.json({
      success: true,
      data: problem
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getRandomProblem
};