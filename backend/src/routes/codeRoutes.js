const express = require('express');
const router = express.Router();
const { submitCode, requestHint } = require('../controllers/codeController');
const { validateCodeSubmission, validateHintRequest } = require('../middleware/validation');

// POST /api/code/submissions - Validate before submitting code
router.post('/submissions', validateCodeSubmission, submitCode);

// POST /api/code/hints - Validate before requesting hint
router.post('/hints', validateHintRequest, requestHint);

module.exports = router;