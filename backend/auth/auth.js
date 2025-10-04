const { expressjwt: jwt } = require('express-jwt');
const jwks = require('jwks-rsa');

// Auth0 configuration
const auth0Config = {
  domain: process.env.AUTH0_DOMAIN,
  audience: process.env.AUTH0_AUDIENCE,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256']
};

// JWT verification middleware
const checkJwt = jwt({
  secret: jwks.expressJwtSecret({
    cache: true,
    rateLimit: true,
    jwksRequestsPerMinute: 5,
    jwksUri: `https://${auth0Config.domain}/.well-known/jwks.json`
  }),
  audience: auth0Config.audience,
  issuer: auth0Config.issuer,
  algorithms: auth0Config.algorithms
});

module.exports = {
  checkJwt
};
