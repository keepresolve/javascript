
// https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty
const object1 = {};
let value  
Object.defineProperty(object1, 'property1', {
//   value: 42, // 不能和get setter一起用 该属性对应的值。可以是任何有效的 JavaScript 值（数值，对象，函数等）。 默认为 undefined。
  configurable: false,  //当且仅当该属性的 configurable 键值为 true 时，该属性的描述符才能够被改变，同时该属性也能从对应的对象上被删除。 默认为 false。
  enumerable:true,  //当且仅当该属性的 enumerable 键值为 true 时，该属性才会出现在对象的枚举属性中。默认为 false。
//   writable: false, //是否可以被重新复制  不能和get setter一起用
  get(val){
    console.log("getter",val,this)
    return value
  },
  set(val){
    console.log("setter",val,this)
    value = val
  }
});
// catch error
// Object.defineProperty(object1, 'property1', {
//     value: 88,
//   //   configurable: false,  //当且仅当该属性的 configurable 键值为 true 时，该属性的描述符才能够被改变，同时该属性也能从对应的对象上被删除。 默认为 false。
//     enumerable:false,  //当且仅当该属性的 enumerable 键值为 true 时，该属性才会出现在对象的枚举属性中。默认为 false。
//     writable: false
//   });
  
object1.property1 = 77;


console.log(object1.property1,Object.keys(object1));

