const express = require('express');
const router = express.Router();
const { getRandomProblem } = require('../controllers/problemController');

router.get('/random', getRandomProblem);

module.exports = router;