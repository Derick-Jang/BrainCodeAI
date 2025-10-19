const { ZodError } = require('zod');
const {
  userRegistrationSchema,
  codeSubmissionSchema,
  hintRequestSchema,
  problemCreationSchema,
  problemCompletionSchema,
  progressRequestSchema
} = require('../validators/schemas');

/**
 * Generic Zod validation middleware factory
 * @param {ZodSchema} schema - The Zod schema to validate against
 * @param {string} source - Where to get data from: 'body', 'query', or 'params'
 * @returns {Function} Express middleware function
 */
const validateRequest = (schema, source = 'body') => {
  return (req, res, next) => {
    try {
      // Validate and transform data
      const validated = schema.parse(req[source]);
      
      // Replace request data with validated/transformed data
      req[source] = validated;
      
      next();
    } catch (error) {
      if (error instanceof ZodError) {
        // Format Zod errors for API response
        const formattedErrors = error.errors.map(err => ({
          field: err.path.join('.'),
          message: err.message
        }));

        return res.status(400).json({
          success: false,
          error: formattedErrors[0]?.message || 'Validation failed',
          details: formattedErrors
        });
      }

      // Pass unexpected errors to error handler
      next(error);
    }
  };
};


// Specific Validators
const validateCodeSubmission = validateRequest(codeSubmissionSchema, 'body');
const validateHintRequest = validateRequest(hintRequestSchema, 'body');
const validateUserRegistration = validateRequest(userRegistrationSchema, 'body');
const validateProblemCreation = validateRequest(problemCreationSchema, 'body');
const validateProblemCompletion = validateRequest(problemCompletionSchema, 'body');
const validateProgressRequest = validateRequest(progressRequestSchema, 'query');

module.exports = {
  validateRequest,
  validateCodeSubmission,
  validateHintRequest,
  validateUserRegistration,
  validateProblemCreation,
  validateProblemCompletion,
  validateProgressRequest
};
