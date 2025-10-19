import { z } from 'zod';

// User Schemas
export const userRegistrationSchema = z.object({
  auth0Id: z.string()
    .min(1, 'Auth0 ID is required'),
  name: z.string()
    .max(100, 'Name must not exceed 100 characters')
    .trim()
    .optional(),
  email: z.string()
    .email('Invalid email address')
    .toLowerCase()
    .trim()
});

// Code Submission Schemas
export const codeSubmissionSchema = z.object({
  code: z.string()
    .min(1, 'Code is required')
    .max(5000, 'Code must not exceed 5000 characters'),
  problemTitle: z.string()
    .min(1, 'Problem title is required')
    .max(100, 'Problem title must not exceed 100 characters')
    .trim(),
  language: z.enum(['javascript', 'python', 'java', 'cpp', 'typescript'], {
    errorMap: () => ({ message: 'Invalid language selected' })
  })
});

export const hintRequestSchema = z.object({
  code: z.string()
    .min(1, 'Code is required')
    .max(5000, 'Code must not exceed 5000 characters'),
  problemTitle: z.string()
    .min(1, 'Problem title is required')
    .max(100, 'Problem title must not exceed 100 characters')
    .trim(),
  language: z.enum(['javascript', 'python', 'java', 'cpp', 'typescript'], {
    errorMap: () => ({ message: 'Invalid language selected' })
  })
});

// Problem Schemas
export const difficultyEnum = z.enum(['Easy', 'Medium', 'Hard'], {
  errorMap: () => ({ message: 'Difficulty must be Easy, Medium, or Hard' })
});

export const problemCreationSchema = z.object({
  title: z.string()
    .min(1, 'Title is required')
    .max(100, 'Title must not exceed 100 characters')
    .trim(),
  description: z.string()
    .min(10, 'Description must be at least 10 characters')
    .max(5000, 'Description must not exceed 5000 characters'),
  difficulty: difficultyEnum,
  examples: z.array(
    z.string().min(1, 'Example cannot be empty')
  ).min(1, 'At least one example is required'),
  constraints: z.array(
    z.string().min(1, 'Constraint cannot be empty')
  ).optional(),
  starterCode: z.string()
    .min(1, 'Starter code is required')
    .max(2000, 'Starter code must not exceed 2000 characters')
});

// Progress/Completion Schemas
export const problemCompletionSchema = z.object({
  problemId: z.number()
    .int('Problem ID must be an integer')
    .positive('Problem ID must be positive'),
  category: z.string()
    .min(1, 'Category is required')
    .trim(),
  auth0Id: z.string()
    .min(1, 'Auth0 ID is required')
});

export const progressRequestSchema = z.object({
  auth0Id: z.string()
    .min(1, 'Auth0 ID is required')
});
