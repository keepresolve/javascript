// for (let i of new Array(10)) {
//   let result = await new Promise(res => {
//     if (that.isBreak) return res({ code: 200 });
//     setTimeout(() => {
//       res(this.$api.get("/modifyEp"));
//     }, 500);
//   });
//   if (this.isBreak) break;
//   console.log(result);
// }

function Observer(data, option) {
  this.data = data;
  const augment = value.__proto__ ? protoAugment : copyAugment;
  augment(value, arrayMethods, key);
  // 兼容不支持 __proto__的方法
  function protoAugment(target, src) {
    target.__proto__ = src;
  }
  // 不支持 __proto__的直接修改先关的属性方法
  function copyAugment(target, src, keys) {
    for (let i = 0, l = keys.length; i < l; i++) {
      const key = keys[i];
      def(target, key, src[key]);
    }
  }
}
var P = Observer.prototype;
var ArrayProto = Array.prototype; // 获取数组原型
var ArrayMethods = Object.create(ArrayProto); //依数组原型创建对象
//重写这几个方法 并劫持
ArrayMethods.aaa = 123;
["push", "pop", "shift", "unshift", "splice", "sort", "reverse"].forEach(
  function(method) {
    // https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty
    Object.defineProperty(ArrayMethods, method, {
      //  value  该属性对应的值。可以是任何有效的 JavaScript 值（数值，对象，函数等）。默认为 undefined
      //  设置默认值 method 进行重写
      value: function() {
        console.log(this);
        const original = arrayProto[method];
        // 传进来的参数
        const args = Array.from(arguments); // 使类数组变成一个真正的数组
        original.apply(this, args);
      }
    });
  }
);

var g = [
  { type: "sug", sa: "s_1", q: "大唐荣耀" },
  { type: "sug", sa: "s_2", q: "大唐芙蓉园" },
  { type: "sug", sa: "s_3", q: "大淘客" },
  { type: "sug", sa: "s_4", q: "大唐双龙传" },
  { type: "sug", sa: "s_5", q: "大唐电信" },
  { type: "sug", sa: "s_6", q: "大逃脱" },
  { type: "sug", sa: "s_7", q: "打胎" },
  { type: "sug", sa: "s_8", q: "大唐好相公" },
  { type: "sug", sa: "s_9", q: "大唐荣耀1" },
  { type: "sug", sa: "s_10", q: "大唐官" }
];
new Observer(g);

g.push({ aa: 123312 });

//数组截取
let arrary = [1, 2, 3, 4, 5, 6, 7, 8, 3, 8, 9, 1];
function cut(arr, num) {
  let result = [];
  for (let i = 0; i < arr.length; i += num) {
    result.push(arr.slice(i, i + num).join(""));
  }
  return result;
}
