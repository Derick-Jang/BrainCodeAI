const OpenAI = require('openai');

if (!process.env.OPENAI_API_KEY) {
  throw new Error('OPENAI_API_KEY environment variable is required');
}

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const OPENAI_CONFIG = {
  MODEL: 'gpt-4o-mini',
  FEEDBACK: {
    MAX_TOKENS: 300,
    TEMPERATURE: 0.3,
  },
  HINT: {
    MAX_TOKENS: 300,
    TEMPERATURE: 0.7,
  }
};

module.exports = {
  openai,
  OPENAI_CONFIG
};