const express = require('express');
const router = express.Router();
const { registerUser, completeProblem, getProgress } = require('../controllers/userController');
const checkJwt = require('../middleware/auth');
const { validateUserRegistration, validateProblemCompletion, validateProgressRequest } = require('../middleware/validation');

router.post('/register', checkJwt, validateUserRegistration, registerUser);
router.post('/complete', checkJwt, validateProblemCompletion, completeProblem);
router.get('/progress', checkJwt, validateProgressRequest, getProgress);

module.exports = router;