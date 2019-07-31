const path = require('path')
require('dotenv-flow').config({
    default_node_env: process.env.NODE_ENV || 'development',
    cwd: path.resolve(__dirname, '../node_env')
})
const debug = require('debug')('koa:preStart')

;(function() {
    //do something before  the app start
    debug('before the app start ')
})()
