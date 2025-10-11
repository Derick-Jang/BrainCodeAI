const express = require('express');
const router = express.Router();
const { submitCode, requestHint } = require('../controllers/codeController');
const { validateCodeSubmission } = require('../middleware/validation');

router.post('/submit', validateCodeSubmission, submitCode);
router.post('/hint', validateCodeSubmission, requestHint);

module.exports = router;