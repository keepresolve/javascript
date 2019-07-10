// 执行栈  funtion 调用堆栈
/**
 * 最好每次console 都来来一个断点
 */
console.log("Global context"); //这个全局环境  1.png
let GlobalVar = "GlobalVar";
first(); //压栈 first                          2.png
console.log("Global context end");

function first() {
  let FirstVar = "FirstVar";
  console.log("Inside first function");
  setTimeout(() => {
    console.log("async callback");
  }, 100);
  second(); //3.png
  console.log("second function end");
  third();
  console.log("third function end");
  fourth();
  console.log("fourth function end");
  //断点
  console.log("Again inside first function");
}

function second() {
  //断点
  let secondVar = "secondVar";
  console.log("Inside second function");
}

function third() {
  //断点
  let thirdVar = "thirdVar";
  console.log("Inside third function");
}
function fourth() {
  //断点
  let fourthVar = "fourthVar";
  console.log("Inside fourth function");
}
