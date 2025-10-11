const app = require('./app');
const { initializeDatabase } = require('./config/database');

const PORT = process.env.PORT || 4000;

// Optional: Initialize database on startup
// initializeDatabase().catch(console.error);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`Health check: http://localhost:${PORT}/api/health`);
});