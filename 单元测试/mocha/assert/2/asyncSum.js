module.exports = async function(...rest) {
  var sum = 0;
  for (let n of rest) {
    sum += n;
  }
  await new Promise(() => {
    setTimeout(() => {}, 3000);
  });
  return sum;
};
