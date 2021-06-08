"use strict";

const Controller = require("egg").Controller;

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    ctx.body = await this.promiseExec("test",ctx.query.value);
  }  
  promiseExec(key, value) {
    const redisClient = this.app.redis.get("client1");
    return new Promise((res) => {
      redisClient
        .multi()
        .set(key, value)
        .exec(function (execError, results) {
          res({ execError, results });
        });
    });
  }
}

module.exports = HomeController;
