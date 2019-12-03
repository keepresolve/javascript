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

// 驼峰

// 解析url
const parse_url = url => {
  let reuslt = /^(?:([A-Za-z]+):)?(\/{,})([-.\-A-Za-z]+)(?::(\d+))?(?:\/([^?#]*))?(?:\?([^#]*))?(?:#(.*))?$/.exec(
    url
  );
  let Obj = {};
  ["url", "scheme", "slash", "host", "port", "path", "query", "hash"].forEach(
    (key, i) => {
      Obj[key] = reuslt[i];
    }
  );

  return Obj;
};
//  var url = "http://qiji.kerlai.net:/GoodsBasic/Operate/?q#simen";
//  var result = parse_url.exec(url);
//  var names = ["url","scheme","slash","host","port","path","query","hash"];
//  for(var i=; i &lt;names.length;i++){
//   console.log(names[i]+":"+result[i]);
//  }
//输出结果
/*
 url:http://qiji.kerlai.net:/GoodsBasic/Operate/?q#simen
 scheme:http
 slash://
 host:qiji.kerlai.net
 port:
 path:GoodsBasic/Operate/
 query:q
 hash:simen
 */
