const { ensureUserExists, getUserIdByAuth0Id, getUserProgress, markProblemComplete } = require('../services/userService');

const registerUser = async (req, res, next) => {
  try {
    const { auth0Id, name, email } = req.body;

    const userId = await ensureUserExists(auth0Id, email, name);
    
    res.json({
      success: true,
      message: 'User registered successfully',
      userId
    });
  } catch (error) {
    next(error);
  }
};

const completeProblem = async (req, res, next) => {
  try {
    const { problemId, category, auth0Id } = req.body;

    const userId = await getUserIdByAuth0Id(auth0Id);
    const completion = await markProblemComplete(userId, problemId, category);
    
    res.json({
      success: true,
      message: 'Problem marked as complete',
      data: {
        id: completion.id
      }
    });
  } catch (error) {
    next(error);
  }
};

const getProgress = async (req, res, next) => {
  try {
    const { auth0Id } = req.query;

    const userId = await getUserIdByAuth0Id(auth0Id);
    const progress = await getUserProgress(userId);
    
    res.json({
      success: true,
      data: progress
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  registerUser,
  completeProblem,
  getProgress
};