// self.addEventListener('message', function (e) {
//     self.postMessage('You said: ' + e.data);
//   }, false);

// 写法一
// this.addEventListener('message', function (e) {
//     this.postMessage('You said: ' + e.data);
//   }, false);

//   // 写法二
//   addEventListener('message', function (e) {
//     postMessage('You said: ' + e.data);
//   }, false);

// console.log({self})

// self.addEventListener('message', function (e) {
//     var data = e.data;
//     switch (data.cmd) {
//       case 'start':
//         self.postMessage('WORKER STARTED: ' + data.msg);
//         break;
//       case 'stop':
//         self.postMessage('WORKER STOPPED: ' + data.msg);
//         self.close(); // Terminates the worker.
//         break;
//       default:
//         self.postMessage('Unknown command: ' + data.msg);
//     };
//   }, false);

//加载外部脚本
// importScripts('script1.js', 'script2.js');

let worker = {
  timer: null,
  createdTime: 0,
  id: 0
};

self.addEventListener(
  "message",
  function(e) {
    var data = e.data;
    console.log("子线程worker message", data);
    switch (data.type) {
      case "start":
        Object.assign(worker, data.worker);
        data.info = "worker" + worker.id + "启动";
        worker.timer = setInterval(() => {
          worker.createdTime = parseInt((Date.now() - worker.id) / 1000);
          self.postMessage(
            Object.assign(data, {
              type: "seconds",
              createdTime: worker.createdTime
            })
          );
        }, worker.delay);
        console.log({ worker });
        break;
      case "end":
        data.info = "worker" + worker.id + "关闭";
        self.close(); // Terminates the worker.
        clearInterval(worker.timer);
        break;
      default:
        break;
    }
    self.postMessage(data);
  },
  false
);

self.addEventListener("error", function(e) {
  self.postMessage({ info: "error", e, id: worker.id });
});
