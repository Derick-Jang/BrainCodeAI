const { ZodError } = require('zod');

const errorHandler = (err, req, res, next) => {
  console.error('Error:', err);

  // Handle Zod validation errors (if they somehow reach here)
  if (err instanceof ZodError) {
    return res.status(400).json({
      success: false,
      error: 'Validation error',
      details: err.errors.map(e => ({
        field: e.path.join('.'),
        message: e.message
      }))
    });
  }

  // Handle JWT errors
  if (err.name === 'UnauthorizedError') {
    return res.status(401).json({
      success: false,
      error: 'Invalid or missing authentication token'
    });
  }

  // Handle known application errors
  if (err.statusCode) {
    return res.status(err.statusCode).json({
      success: false,
      error: err.message
    });
  }

  // Handle known errors
  if (err.message === 'User not found') {
    return res.status(404).json({
      success: false,
      error: err.message
    });
  }

  // Handle database errors
  if (err.code === '23505') { // Postgres unique violation
    return res.status(409).json({
      success: false,
      error: 'Resource already exists'
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