// https://html.spec.whatwg.org/multipage/webappapis.html#event-loop
// 一个事件循环有一个或多个任务队列。一个 任务队列是一组的任务。
// 任务队列是集合，而不是队列，因为事件循环处理模型的第一步从所选队列中获取第一个可运行 任务，而不是使第一个任务出列。
// 该microtask队列不是一个任务队列。 该微任务队列不是任务队列。

// Events
// 在特定EventTarget对象上分派事件对象通常由专用任务完成  并不是所有事件都使用任务队列进行分派;许多人在执行其他任务时被派遣。

// Parsing
// 文：HTML解析器标记一个或多个字节，然后处理任何产生的标记，这通常是一项任务。
// Callbacks
// ：调用回调通常由专用任务完成

// Using a resource
// 当算法获取资源时，如果获取是以非阻塞的方式发生的，那么一旦部分或全部资源可用，就由任务执行对资源的处理

// Reacting to DOM manipulation
// 有些元素具有响应DOM操作的任务，例如当该元素插入到文档中时。

// ：在形式上，任务是一个结构体，它具有:
// steps
// 指定任务要完成的工作的一系列步骤。
// A source
// 任务源之一，用于对相关任务进行分组和序列化。
// A document
// 与任务关联的文档，对于不在window事件循环中的任务为空。
// A script evaluation environment settings object set
// ：一组环境设置对象，用于跟踪任务期间的脚本评估。

// -个任务是可运行的 ，如果它的文档是null或充分活跃。
// 据其源字段，每个任务被定义为来自特定任务源。对于每个事件循环，每个任务源都必须与特定任务队列相关联。

console.log("Global context"); //这个全局环境
let GlobalVar = "GlobalVar";
first(); //压栈 first
console.log("Global context end");

function first() {
  let FirstVar = "FirstVar";
  console.log("Inside first function");
  setTimeout(() => {
    console.log("fifth setTimeout of   callback");
  }, 0);

  let pro = new Promise(res => {
    var secondVar = "secondVar";
    console.log("second promise");
    res(console.log("second promise result"));
  });
  pro.then(() => {
    console.log(" fourth promise then");
  });
  let pro2 = new Promise(res => {
    var secondVar2 = "secondVar2";
    console.log("second promise2");
    setTimeout(() => {
      res(console.log("sixth settimeout of promise  result"));
    }, 0);
  });
  third();
  console.log("third function end");
  console.log("will out first context");
}

function third() {
  //断点
  let thirdVar = "thirdVar";
  console.log("Inside third function");
}
