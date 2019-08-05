(function(global, factory) {
  typeof exports === "object" && typeof module !== "undefined"
    ? (module.exports = factory())
    : typeof define === "function" && define.amd
    ? define(factory)
    : ((global = global || self), (global.Workers = factory()));
})(this, function() {
  "use strict";
  if (!self.Worker && !Worker && !this.Worker) {
    throw `The current environment does not support Worker`;
  }

  function createWorker(option, list, eventCb) {
    let { url } = option;
    if (!url) throw "The worker's url cannot be empty";
    let that = this;
    let worker = new Worker(url);
    Object.assign(worker, option);

    worker.addEventListener("message", function(event) {
      let data = event.data;

      // console.log(`主线程收到：worker${data.worker.id} message`, data);
      switch (data.type) {
        case "start":
          break;
        case "end":
          break;
        case "error":
          break;
        case "seconds":
          let { createdTime } = data;
          this.createdTime = createdTime;
          break;
        case "custom":
          let { msg } = data;
          this.msg = msg;
          break;
        default:
          break;
      }
      eventCb(event, worker, list);
    });
    worker.addEventListener("error", function(e) {
      console.error({ e });
      that.terminate(worker.id);
    });

    worker.postMessage({ type: "start", worker: cloneWorker(worker) });

    return worker;
  }

  function Workers(url, option) {
    if (!(this instanceof Workers)) return new Workers(url, option);
    this.workerPool = []; //worker 池
    this.url = url; //全局加载url地址
    //copy 参数
    this.option = Object.assign({}, option || {});

    //event Callback
    this.option.message = this.option.message
      ? this.option.message.bind(this)
      : function() {};
    this.option.change = this.option.change || function() {};
  }
  Workers.prototype = {
    create(option) {
      let id = Date.now();
      let createOption = Object.assign(
        {
          name: `worker-${id}`,
          url: this.url
        },
        option
      );
      createOption.id = id;
      createOption.createdTime = 0;

      let worker = createWorker.call(
        this,
        createOption,
        this.workerPool,
        this.option.message
      );
      this.workerPool.push(worker);
      this.change(worker, "create");
      return worker;
    },
    terminate(id) {
      let index = this.findIndex(id);
      if (index == -1) return null;
      let worker = this.workerPool[index];

      worker.postMessage({ type: "end", worker: cloneWorker(worker) });
      this.workerPool.splice(index, 1);
      this.change(worker, "remove");
      return worker;
    },
    find(id) {
      let worker = this.workerPool.find((v, i) => v.id == id);
      return worker;
    },
    findIndex(id) {
      let index = this.workerPool.findIndex((v, i) => v.id == id);
      return index;
    },
    change(item, method) {
      this.option.change.call(this, this.workerPool, item, method);
    },
    get length() {
      return this.workerPool.length;
    },
    get list() {
      return this.workerPool;
    }
  };
  function cloneWorker(worker) {
    let obj = {};
    Object.keys(worker).map(key => {
      if (typeof worker[key] != "function") obj[key] = worker[key];
    });
    return obj;
  }
  return Workers;
});
