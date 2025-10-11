const errorHandler = (err, req, res, next) => {
    console.error('Error:', err);
  
    // Handle JWT errors
    if (err.name === 'UnauthorizedError') {
      return res.status(401).json({
        success: false,
        error: 'Invalid or missing authentication token'
      });
    }
  
    // Handle known errors
    if (err.message === 'User not found') {
      return res.status(404).json({
        success: false,
        error: err.message
      });
    }
  
    // Generic error
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  };
  
  const notFoundHandler = (req, res) => {
    res.status(404).json({
      success: false,
      error: 'Route not found'
    });
  };
  
  module.exports = {
    errorHandler,
    notFoundHandler
  };