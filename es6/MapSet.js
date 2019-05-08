// Map结构提供了“值—值”的对应，是一种更完善的Hash结构实现。如果你需要“键值对”的数据结构，
// Map比Object更合适。它类似于对象，也是键值对的集合，
// 但是“键”的范围不限于字符串，各种类型的值（包括对象）都可以当作键。
let testMap=new Map()
var o={1:123}
var a=o
testMap.set(o,"sadasd")
testMap.set(2,"sasdasdadasd")
console.log(JSON.stringify(testMap.get(a)))


// set Set函数可以接受一个数组（或类似数组的对象）作为参数，用来初始化。