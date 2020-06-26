//new的实现
function myNew(fn, ...arg) {
  const obj = Object.create(fn.prototype); //当前原型实例
  const ret = fn.call(obj, ...arg);
  console.log("new:实例 " + fn.name + "函数", ret instanceof Object);
  return ret instanceof Object ? ret : obj;
}

function testmyNew() {
  this.test1 = function () {
    console.log("new:testmyNew原型方法 test1", typeof this);
  };
}
testmyNew.prototype.test = function () {
  console.log("new:testmyNew原型方法 test");
};
const instance = myNew(testmyNew);
const instance1 = new testmyNew();
console.log("new:当前实例", instance, instance1);
console.log(
  "new:当前实例合new关键字对比",
  JSON.stringify(instance) == JSON.stringify(instance1)
);

// // call
// function testCall() {
//   this.test1 = function () {
//     console.log("call:testCall方法:test1");
//   };
// }
// testCall.prototype.test = function () {
//   console.log("call:testCall原型方法:test");
// };
// function testCall1() {
//   //   this.test1 = function () {
//   //     console.log("testCall1:this.test1");
//   //   };
//   console.log("testCall1", typeof this);
//   testCall.call(this);
//   //   this.test1 = function () {
//   //     console.log("testCall1:this.test1");
//   //   };
// }
// testCall1.prototype.test1 = function () {
//   console.log("testCall1:test1");
// };

// const test = new testCall1();
// test.test1();
function getGlobal() {
  if (typeof self !== "undefined") {
    return self;
  }
  if (typeof window !== "undefined") {
    return window;
  }
  if (typeof global !== "undefined") {
    return global;
  }
  throw new Error("unable to locate global object");
}

// function mytestCall1(){
// mytestCall.call(this,arg1,arg3)
// }

// call
Function.prototype.myCall = function (context, ...arg) {
  // context = 'mytestCall1' || globalThis //需要修改的this 指针
  // arg = [rg1,arg3]  //需要继承的参数
  // this = mytestCall  当前作用于的this

  if (typeof this !== "function") {
    throw new TypeError("this is not a function");
  }
  try {
    context = globalThis;
  } catch (error) {
    context = getGlobal();
  }
  // 挂载到context就是需要改变的this指针(mytestCall1)上一个方法fn
  context.fn = this;
  //执行这个context.fn() 当前作用域的this变成了 context
  const ret = context.fn(...arg);
  // 清空执行当前添加的fn
  delete context.fn;
  //返回执行结果
  return ret;
};

// apply
// 同上的原理  不过arg 参数成了数组
// function mytestCall1(){
// mytestCall.call(this,[arg1,arg2])
// }
Function.prototype.myApply = function (context, arg) {
  // context = 'mytestCall1' || globalThis //需要修改的this 指针
  // arg = [rg1,arg3]  //需要继承的参数
  // this = mytestCall  当前作用于的this

  if (typeof this !== "function") {
    throw new TypeError("this is not a function");
  }
  try {
    context = globalThis;
  } catch (error) {
    context = getGlobal();
  }
  // 挂载到context就是需要改变的this指针(mytestCall1)上一个方法fn
  context.fn = this;
  //执行这个context.fn() 当前作用域的this变成了 context
  let ret = null;
  if (arg) {
    //防止传参undefined
    ret = context.fn(...arg);
  } else {
    ret = context.fn();
  }
  // 清空执行当前添加的fn
  delete context.fn;
  //返回执行结果
  return ret;
};

//bind
// const a = {
//     test:function(){
//         console.log(this.arg)
//     }
// }
// function mytestCall1(...arg){
//     this.arg= arg
//     this.test()
// }
// mytestCall1.bind(a,"name1")("name2")
Function.prototype.myBind = function (context, ...arg) {
  // context = a  需要绑定的对象
  // arg = [rg1,arg3]  //需要继承的参数
  // this = mytestCall1  当前函数的作用域this
  if (typeof this !== "function") {
    throw new TypeError("this is not a function");
  }
  const _this = this //mytestCall1
  return function(...withArg){
    _this.call(context,...arg,...withArg)
    // mytestCall1.call()
  }

};
// mytestCall1.bind(a,"name1")("name2")
