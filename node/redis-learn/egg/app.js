process.on("uncaughtException", function (err) {
  //当前进程出问题
  console.log("uncaughtException", err);
});
module.exports = class Boot {
  constructor(app) {
    this.app = app;
    this.eventListern();
  }
  eventListern() {
    const app = this.app;
    app.once("server", (server) => {
      // websocket
      console.log("server");
    });
    app.on("error", (err, ctx) => {
      // report error
      console.log("error", err);
    });
    app.on("request", (ctx) => {
      // log receive request
      console.log("request");
    });
    app.on("response", (ctx) => {
      console.log("response");
      // ctx.starttime is set by framework
      const used = Date.now() - ctx.starttime;
      // log total cost
    });

    app.messenger.on("angent_action", (data) => {
      console.log("from angent angent_action", { data });
      // ...
    });
  }
  configWillLoad() {
    // 此时 config 文件已经被读取并合并，但是还并未生效
    // 这是应用层修改配置的最后时机
    // 注意：此函数只支持同步调用
    // 例如：参数中的密码是加密的，在此处进行解密
    // this.app.config.mysql.password = decrypt(this.app.config.mysql.password);
    // 例如：插入一个中间件到框架的 coreMiddleware 之间
    // const statusIdx = this.app.config.coreMiddleware.indexOf("status");
    // this.app.config.coreMiddleware.splice(statusIdx + 1, 0, "limit");
  }
  configDidLoad() {
    console.log("configDidLoad");
  }
  async didLoad() {
    // 所有的配置已经加载完毕
    // 可以用来加载应用自定义的文件，启动自定义的服务

    // 例如：创建自定义应用的示例
    // this.app.queue = new Queue(this.app.config.queue);
    // await this.app.queue.init();

    // 例如：加载自定义的目录
    // this.app.loader.loadToContext(path.join(__dirname, "app/tasks"), "tasks", {
    //   fieldClass: "tasksClasses",
    // });
  }

  async willReady() {
    // 所有的插件都已启动完毕，但是应用整体还未 ready
    // 可以做一些数据初始化等操作，这些操作成功才会启动应用

    // 例如：从数据库加载数据到内存缓存
    // this.app.cacheData = await this.app.model.query(QUERY_CACHE_SQL);
    const redisClient = this.app.redis.get("client1");
    redisClient.watch("test");
  }

  async didReady() {
    // 应用已经启动完毕
    // const ctx = await this.app.createAnonymousContext();
    // await ctx.service.Biz.request();
  }

  async serverDidReady() {
    // http / https server 已启动，开始接受外部请求
    // 此时可以从 app.server 拿到 server 的实例

    this.app.server.on("timeout", (socket) => {
      // handle socket timeout
    });
  }
};