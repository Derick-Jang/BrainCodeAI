const validateCodeSubmission = (req, res, next) => {
    const { code, problemTitle, language } = req.body;
  
    if (!code || typeof code !== 'string') {
      return res.status(400).json({
        success: false,
        error: 'Code is required and must be a string'
      });
    }
  
    if (code.trim().length === 0) {
      return res.status(400).json({
        success: false,
        error: 'Code cannot be empty'
      });
    }
  
    if (code.length > 5000) {
      return res.status(400).json({
        success: false,
        error: 'Code is too long (max 5000 characters)'
      });
    }
  
    if (!problemTitle || !language) {
      return res.status(400).json({
        success: false,
        error: 'Problem title and language are required'
      });
    }
  
    next();
  };
  
  const validateUserRegistration = (req, res, next) => {
    const { auth0Id, name, email } = req.body;
  
    if (!auth0Id || !name || !email) {
      return res.status(400).json({
        success: false,
        error: 'Missing user information (auth0Id, name, email required)'
      });
    }
  
    next();
  };
  
  const validateProblemCompletion = (req, res, next) => {
    const { problemId, category, auth0Id } = req.body;
  
    if (!problemId || !category || !auth0Id) {
      return res.status(400).json({
        success: false,
        error: 'Missing problem information (problemId, category, auth0Id required)'
      });
    }
  
    next();
  };
  
  const validateProgressRequest = (req, res, next) => {
    const { auth0Id } = req.query;
  
    if (!auth0Id) {
      return res.status(400).json({
        success: false,
        error: 'Missing user information (auth0Id required)'
      });
    }
  
    next();
  };
  
  module.exports = {
    validateCodeSubmission,
    validateUserRegistration,
    validateProblemCompletion,
    validateProgressRequest
  };