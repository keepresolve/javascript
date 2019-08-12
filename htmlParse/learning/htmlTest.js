let fs = require("fs");
let htmlStr = fs.readFileSync("./index.html", "utf-8");

let tagState = {
  begin() {}
};

let parse = new ParseHTMLStr(htmlStr);

function ParseHTMLStr(str) {
  let state = data;
  let token = null;
  let attribute = null;
  let characterReference = "";
  this.entry = function(char) {
    if (state == null) {
      throw new Error("there is an error");
    } else {
      state = state(char); //格里化函数
    }
  };
  return function() {
    while (str.length > 0) {
      let char = str.slice(0, 1);
      str = str.slice(1);
    }
  }.bind(this)();
}
function data(c) {
  switch (c) {
    case "<":
      return function(c) {
        if (c === "/") {
          return function() {};
        }
      };
      break;
    case "":
      break;
  }
}
