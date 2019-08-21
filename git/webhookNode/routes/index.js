const router = require('koa-router')()

router.all('/webhook', async (ctx, next) => {
      let body=ctx.request.body
      // body.ctxs=ctxs
      for(let i = 0; i < ctxs.length; i++) {
          ctxs[i].websocket.send(JSON.stringify(body));
      }
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
