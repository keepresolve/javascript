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
