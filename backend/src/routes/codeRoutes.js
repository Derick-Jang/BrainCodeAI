const express = require('express');
const router = express.Router();
const { submitCode, requestHint } = require('../controllers/codeController');
const { validateCodeSubmission, validateHintRequest } = require('../middleware/validation');

// POST /api/code/submit - Validate before submitting code
router.post('/submit', validateCodeSubmission, submitCode);

// POST /api/code/hint - Validate before requesting hint
router.post('/hint', validateHintRequest, requestHint);

module.exports = router;