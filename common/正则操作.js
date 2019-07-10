// 首位空格
const trim = function(string) {
  return (string || "").replace(/^[\s\uFEFF]+|[\s\uFEFF]+$/g, "");
};

// 5-99999 /^[5-9]{1}$|^[1-9]\d{1,5}$/

// 请输入1-365天的整数 /^3[0-5]{1}\d{1}$|^36[0-5]{1}$|^[1-2]?\d{1}\d{1}$|^[1-9]{1}$/

const vaild_port = value => {
  if (!/^[1-9]\d*$/.test(value) || value > 65535) return false;
  return true;
  // return callback(new Error("请输入0-65535范围的正整数"));
};
const vaild_365 = value =>
  /^3[0-5]{1}\d{1}$|^36[0-5]{1}$|^[1-2]?\d{1}\d{1}$|^[1-9]{1}$/.test(value);
