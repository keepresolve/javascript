const router = require('koa-router')()

router.all('/webhook', async (ctx, next) => {
     console.log(ctx)
     ctx.body={
       status:200
     }
})

router.get('/string', async (ctx, next) => {
  ctx.body = 'koa2 string'
})

router.get('/json', async (ctx, next) => {
  ctx.body = {
    title: 'koa2 json'
  }
})

module.exports = router
