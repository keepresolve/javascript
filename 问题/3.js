// 第三题
var myobject = {};
var newobject = {};
// 要求1
var _extend = function(target) {
  for (var i = 1; i < arguments.length; i++) {
    var source = arguments[i];
    for (var key in source) {
      if (Object.prototype.hasOwnProperty.call(source, key)) {
        target[key] = source[key];
      }
    }
  }
  return target;
};
_extend(newobject, myobject);

// 要求2
newobject = Object.assign({}, myobject);
newobject = { ...myobject };
//要求3
function Clone(target) {
  // 判断拷贝的数据类型,初始化变量result 成为最终克隆的数据
  let result;
  switch (Object.prototype.toString.call(target)) {
    case "[object Object]":
      result = {};
      break;
    case "[object Array]":
      result = [];
      break;
    default:
      return;
  }
  // 遍历目标数据
  for (let i in target)
    result[i] = ["[object Object]", "[object Array]"].includes(
      Object.prototype.toString.call(target[i])
    )
      ? clone(target[i])
      : target[i];
  return result;
}

// 要求4
newobject = JSON.parse(JSON.stringify(myobject));
