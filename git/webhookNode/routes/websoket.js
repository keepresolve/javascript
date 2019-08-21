

// ws

/* 实现简单的接发消息 */
function websocket(ctx, next)  {
  /* 每打开一个连接就往 上线文数组中 添加一个上下文 */
  ctxs.push(ctx);
  ctx.websocket.on("message", (message) => {
      console.log(message);
      for(let i = 0; i < ctxs.length; i++) {
          if (ctx == ctxs[i]) continue;
          ctxs[i].websocket.send(message+'\r\n'+JSON.stringify(ctxs));
      }
  });
  ctx.websocket.on("close", (message) => {
      /* 连接关闭时, 清理 上下文数组, 防止报错 */
      let index = ctxs.indexOf(ctx);
      ctxs.splice(index, 1);
  });
  
}

function message(obj){
    return JSON.stringify(obj)
}

module.exports = websocket
