const router = require('koa-router')()

const controller = require('../controller/index')
router.prefix(process.env.baseUri ? process.env.baseUri : '/') //请求前缀

//登陆注册
router.all('/register', async ctx => {
    ctx.response.body = await controller.login.register(ctx)
})
router.all('/login', async ctx => {
    ctx.response.body = await controller.login.login(ctx)
})

router.get('/query', async ctx => {
    ctx.response.body = await controller.mysql.query(ctx)
})
//jscrop learning.html
router.all('/upload', async ctx => {
    ctx.response.body = await controller.upload.upload(ctx)
})
router.post('/sliceUpload', async ctx => {
    ctx.response.body = await controller.upload.sliceUpload(ctx)
})
//流下载
router.all('/download', async ctx => {
    ctx.response.body = await controller.download.stream(ctx)
})
module.exports = router
