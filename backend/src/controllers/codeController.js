const { generateFeedback, generateHint } = require('../services/aiService');

const submitCode = async (req, res, next) => {
  try {
    const { code, problemTitle, language } = req.body;

    const feedback = await generateFeedback(problemTitle, code, language);

    res.json({
      success: true,
      data: {
        feedback,
        submittedAt: new Date().toISOString(),
      }
    });
  } catch (error) {
    if (error.code === 'insufficient_quota') {
      return res.status(429).json({
        success: false,
        error: 'AI service temporarily unavailable. Please try again later.'
      });
    }

    if (error.code === 'rate_limit_exceeded') {
      return res.status(429).json({
        success: false,
        error: 'Too many requests to AI service. Please wait a moment and try again.'
      });
    }

    next(error);
  }
};

const requestHint = async (req, res, next) => {
  try {
    const { code, problemTitle, language } = req.body;

    const hint = await generateHint(problemTitle, code, language);

    res.json({
      success: true,
      hint
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  submitCode,
  requestHint
};