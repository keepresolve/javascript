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
let id= 0
let timer=null
let time=0
self.addEventListener('message', function (e) {
    var data = e.data;
    console.log('worker'+data.id+'线程message',{data,self})
    switch (data.type) {
      case 'start':
        data.info='worker'+ data.id+'启动'
        id=data.id
        timer=setInterval(()=>{
          time+=1
          self.postMessage(Object.assign(data,{type:"seconds",time}));
        },1000)
        break;
      case 'end':
          data.info='worker'+ data.id +'关闭' 
          self.close(); // Terminates the worker.
          clearInterval(timer)
        break;
      default:
    };
    self.postMessage(data);
  }, false);

  self.addEventListener("error",function(e){
      self.postMessage({info:"error",e,id});
  })