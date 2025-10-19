const express = require('express');
const router = express.Router();

const problemRoutes = require('./problemRoutes');
const codeRoutes = require('./codeRoutes');
const userRoutes = require('./userRoutes');

// Health check
router.get('/health', (req, res) => {
  res.json({ 
    status: 'OK',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Mount route modules
router.use('/problems', problemRoutes);
router.use('/code', codeRoutes);
router.use('/users', userRoutes);

module.exports = router;