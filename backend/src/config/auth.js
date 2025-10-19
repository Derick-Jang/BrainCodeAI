/**
 * Auth0 Configuration
 * Centralized Auth0 settings used across the application
 */

if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
    throw new Error('AUTH0_DOMAIN and AUTH0_AUDIENCE environment variables are required');
}

const auth0Config = {
  domain: process.env.AUTH0_DOMAIN,
  audience: process.env.AUTH0_AUDIENCE,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256'],
  jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json`
};

module.exports = auth0Config;