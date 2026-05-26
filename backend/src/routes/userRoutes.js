const express = require('express');
const router = express.Router();
const { registerUser, completeProblem, getProgress } = require('../controllers/userController');
const checkJwt = require('../middleware/auth');
const { validateUserRegistration, validateProblemCompletion, validateProgressRequest } = require('../middleware/validation');

router.post('/', checkJwt, validateUserRegistration, registerUser);
router.post('/completions', checkJwt, validateProblemCompletion, completeProblem);
router.get('/progress', checkJwt, validateProgressRequest, getProgress);

module.exports = router;