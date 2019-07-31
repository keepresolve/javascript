const router = require('koa-router')()
const controller = require('./controller')
let { errorCode } = require('../config')

//https://cnodejs.org/topic/5b13c12157137f22415c4892 koa-router详细解释
// 错误统一处理  throw 并返回
const errHandler = async (ctx, next) => {
    //response.status default 404, check https://koajs.com/#response
    //response.body 一旦设置就改为200
    try {
        ctx.response.set('Access-Control-Allow-Origin', '*')
        await next()
    } catch (err) {
        if (err.hasOwnProperty('custom')) {
            err.info = err.info ? err.info : errorCode(err.status)
            delete err.custom
            logger.debug('emit custom error')
            ctx.response.body = err
        } else {
            ctx.response.status = err.statusCode || err.status || 500
            ctx.response.body = { status: 99999, info: err.message }
            logger.debug(`emit system error`)
        }
        ctx.app.emit('error', err, ctx)
    }
}
//参数处理
router.use(async (ctx, next) => {
    let url = ctx.request.path
    let method = ctx.method.toLowerCase()
    //这个最好要改，我们自己至少要支持 put/head/delete
    if (method != 'get' && method != 'post') {
        debug('need to find a way to use router.allowedMethods()')
        ctx.response.body = { status: 30004, info: '不支持http方法' }
        return
    }
    let req = ctx.request
    let data = method == 'get' ? ctx.request.query : ctx.request.body
    data.files = req.files
    ctx.input_params = data
    await next()
})
router.use(errHandler) //错误处理
router.use(controller.routes()) //分类处理路由
module.exports = router
