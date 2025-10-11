const { openai, OPENAI_CONFIG } = require('../config/openai');
const { createFeedbackPrompt, createHintPrompt } = require('../utils/prompts');

const generateFeedback = async (problemTitle, code, language) => {
  const prompt = createFeedbackPrompt(problemTitle, code, language);

  const completion = await openai.chat.completions.create({
    model: OPENAI_CONFIG.MODEL,
    messages: [
      {
        role: "system",
        content: "You are a helpful and encouraging technical interviewer providing code review feedback."
      },
      {
        role: "user",
        content: prompt
      }
    ],
    max_tokens: OPENAI_CONFIG.FEEDBACK.MAX_TOKENS,
    temperature: OPENAI_CONFIG.FEEDBACK.TEMPERATURE,
  });

  const feedback = completion.choices[0]?.message?.content;

  if (!feedback) {
    throw new Error('No feedback received from AI');
  }

  return feedback.trim();
};

const generateHint = async (problemTitle, code, language) => {
  const prompt = createHintPrompt(problemTitle, code, language);

  const completion = await openai.chat.completions.create({
    model: OPENAI_CONFIG.MODEL,
    messages: [
      { 
        role: "system", 
        content: "You are a helpful technical interview coach specializing in LeetCode problems. Provide concise, thoughtful hints that guide without giving away solutions."
      },
      { 
        role: "user", 
        content: prompt 
      }
    ],
    temperature: OPENAI_CONFIG.HINT.TEMPERATURE,
    max_tokens: OPENAI_CONFIG.HINT.MAX_TOKENS
  });

  const hint = completion.choices[0]?.message?.content;

  if (!hint) {
    throw new Error('No hint generated');
  }

  return hint;
};

module.exports = {
  generateFeedback,
  generateHint
};