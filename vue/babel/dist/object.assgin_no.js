"use strict";

var obj1 = {
  a: 1,
  b: 2,
  c: 3
};
var obj2 = {
  d: 4,
  c: 5
};
Object.assign(obj1, obj2);
console.log(obj1);