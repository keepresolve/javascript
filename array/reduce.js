var numbers = [65, 44, 12, 4];

let total = numbers.reduce((total, num) => {
  return total + num;
});
let obj = {
  length: 20
};
// let arr = new Array(20).fill(0, 0, 20);

let increment = function(num) {
  if (!num || isNaN(num)) return [];
  let i = 0;
  let result = [];
  var fn = function() {
    if (++i > num) return;
    result.push(i);
    fn();
  };
  fn();
  return result;
};
let arr = increment(20);

