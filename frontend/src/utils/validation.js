/**
 * Format Zod validation errors for display
 * @param {ZodError} error - Zod validation error
 * @returns {string} Formatted error message
 */
export const formatZodError = (error) => {
  // Check if error has issues array
  if (error.issues && error.issues.length > 0) {
    if (error.issues.length === 1) {
      return error.issues[0].message;
    }
    return error.issues.map(issue => issue.message).join(', ');
  }

  return 'Validation failed';
};
