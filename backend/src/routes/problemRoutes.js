const express = require('express');
const router = express.Router();
const { getRandomProblem } = require('../controllers/problemController');

router.get('/', getRandomProblem);

module.exports = router;