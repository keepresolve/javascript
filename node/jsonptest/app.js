const Koa =require("koa")
const path =require("path")
const app = new Koa()
const Router = require('koa-router'); //路由
const router = new Router()
//middleware
app.use(require("koa-static")(path.resolve(__dirname,"./public")))
app.use(async function(ctx,next){
   await next()
   console.log(`${new Date().toLocaleString()}:${ctx.body}`)
  
})
//jsonp
router.get("/jsonp",async function(ctx){
        let { callback } = ctx.request.query;
        ctx.type='text/javascript'
        // ctx.type = 'text';
        let data = JSON.stringify({
            flag:0,
            list:[]
        })
        ctx.response.body = `${callback}(${data})`  //js返回执行

})
//option 与检查
router.all("/cors", async function(ctx){
    ctx.set('Access-Control-Allow-Origin', '*');
    ctx.set('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
    ctx.set('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');
    let query = ctx.request.query;
    ctx.response.body = {
        query
    }  //js返回执行

})
router.post("/nocors", async function(ctx){
    let query = ctx.request.query;
    ctx.response.body = {
        query
    }  //js返回执行

})

app.use(router.routes()).use(router.allowedMethods());
app.listen(3000,function(){
    console.log("listen at 3000")
})