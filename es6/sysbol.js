var obj = {
  a: 1,
  b: 2,
  c: 3,
  length: 3
};
obj[Symbol.iterator] = function() {
  console.log(arguments);
};
console.log(obj[Symbol.iterator]());
