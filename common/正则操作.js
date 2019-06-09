// 首位空格
const trim = function(string) {
    return (string || '').replace(/^[\s\uFEFF]+|[\s\uFEFF]+$/g, '');
  };