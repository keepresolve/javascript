//数据格式转化
let arr = [1, 2, 3, 4];  //=>["111", "112", "241"];
/**
 *
 * @param {*合并的数组} array
 * @param {*合并字符数量} num
 * @param {*前一个字段} pre
 */
function joinNum(array, num, pre = "") {
  num--;
  let result = [];
  for (let index = 0; index < array.length; index++) {
    if (num <= 0) {
      result.push(pre + "" + array[index]);
    } else {
      result = result.concat(joinNum(array, num, pre + "" + array[index]));
    }
  }
  return result;
}
