import { 
  codeSubmissionSchema, 
  hintRequestSchema, 
  problemCompletionSchema, 
  userRegistrationSchema 
} from '../validators/schemas';
import { formatZodError } from '../utils/validation';

/**
 * Generic validation function that handles Zod schema validation
 * @param {ZodSchema} schema - Zod schema to validate against
 * @param {Object} data - Data to validate
 * @returns {Object} { success: boolean, data?: Object, error?: string }
 */
const validateWithSchema = (schema, data) => {
  const result = schema.safeParse(data);
  
  if (result.success) {
    return {
      success: true,
      data: result.data
    };
  }
  
  return {
    success: false,
    error: formatZodError(result.error)
  };
};

/**
 * Validates code submission data
 * @param {Object} data - { code, problemTitle, language }
 * @returns {Object} Validation result
 */
export const validateCodeSubmission = (data) => {
  return validateWithSchema(codeSubmissionSchema, data);
};

/**
 * Validates hint request data
 * @param {Object} data - { code, problemTitle, language }
 * @returns {Object} Validation result
 */
export const validateHintRequest = (data) => {
  return validateWithSchema(hintRequestSchema, data);
};

/**
 * Validates problem completion data
 * @param {Object} data - { problemId, category, auth0Id }
 * @returns {Object} Validation result
 */
export const validateProblemCompletion = (data) => {
  return validateWithSchema(problemCompletionSchema, data);
};

/**
 * Validates user registration data
 * @param {Object} data - { auth0Id, name, email }
 * @returns {Object} Validation result
 */
export const validateUserRegistration = (data) => {
  return validateWithSchema(userRegistrationSchema, data);
};
