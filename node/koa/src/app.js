const Koa = require('koa')
const app = new Koa()
global.app = app
require('./util/init')()
const PORT = process.env.port || 3000
app.listen(PORT)
logger.debug(`app starts at ${PORT}`)
module.exports = app
