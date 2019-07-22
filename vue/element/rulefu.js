var validatePass = function(rule, value, callback) {
  console.log({ rule, value, callback });
  if (value === "") {
    callback(new Error("两次输入密码不一致!"));
  } else {
    callback();
  }
};
var rules = [{ required: true, validator: validatePass }];
