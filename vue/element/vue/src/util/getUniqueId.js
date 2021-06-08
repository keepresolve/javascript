/**
 * 获取唯一id
 *
 * @param
 *   prefix(String): 前缀
 *
 * @return String
 *
 */

var uniqueIdCounter = 0;

export default (prefix) => {
  var timestamp = new Date().getTime().toString(),
    id = timestamp + uniqueIdCounter++;
  return prefix ? prefix + id : id;
};
