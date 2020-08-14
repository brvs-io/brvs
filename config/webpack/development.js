process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.config.merge({
  devServer: {
    public: process.env.WEBPACK_HOST,
    port: 3036,
    allowedHosts: [
      process.env.BRVS_DEFAULT_DOMAIN
    ],
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, PATCH, OPTIONS",
      "Access-Control-Allow-Headers": "X-Requested-With, content-type, Authorization"
    }
  }
})

module.exports = environment.toWebpackConfig()
