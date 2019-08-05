const path = require('path')
// let Promise = require('bluebird') // Promise 转换工具
const koaBody = require('koa-body') //请求参数解析 附带files  //https://stackoverflow.com/questions/33751203/how-to-parse-multipart-form-data-body-with-koa
//环境变量
require('dotenv-flow').config({
    default_node_env: process.env.NODE_ENV || 'development',
    cwd: path.resolve(__dirname, '../node_env') //env 路径
})

const debug = require('debug')('koa:init')

module.exports = function() {
    // 全局的对象挂载对象  仅仅是一个示例
    debug('app mounts objects ')
    let { db } = require('../database')
    app.db = db
    app.root = path.resolve(
        __dirname,
        process.env.root ? process.env.root : '../../'
    )
    app.static = path.resolve(
        __dirname,
        process.env.static ? process.env.static : '../../static'
    )

    // logger
    debug('set up logger') //logger要放在启动我们自己包的最前面，因为我们自己包都会记录logger
    require('./logger')

    // middleware
    debug('router register')
    app.use(koaBody({ multipart: true }))
    debug('static init at' + app.static)
    app.use(require('koa-static')(app.static))
    const router = require('../routes')
    app.use(router.routes()).use(router.allowedMethods())

    // error监听
    app.on('error', err => {
        logger.error(`${err.message ? err.message : err.info} : ${err.stack}`)
        console.error(`${err.message ? err.message : err.info} : ${err.stack}`)
    })
}
