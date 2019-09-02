// let fs = require("fs");
// let htmlStr = fs.readFileSync("./index.html", "utf-8");



// let parse = new ParseHTMLStr(htmlStr);

function ParseHTMLStr(syntaxer) {
  let state = data;
  let token = null;
  let attribute = null;
  let characterReference = "";
  this.receiveInput = function(char) {
    if (state == null) {
      throw new Error("there is an error");
    } else {
      state = state(char); //格里化函数
    }
  };
  this.reset = function() {
    state = data;
  };
  function data(c) {
    switch (c) {
      case "<":
        return tagOpen
        case "&":
          return characterReferenceInData;
    }
  }
  
  function tagOpen(c) {
    if (c === "/") {
      return endTagOpen;
    }
    if (/[a-zA-Z]/.test(c)) {
      token = new StartTagToken();
      token.name = c.toLowerCase();
      return tagName;
    }
    // no need to handle this
    // if (c === '?') {
    //   return bogusComment
    // }
    return error(c);
  }
  function tagName(c) {
    // if (c === "/") {
    //   return selfClosingTag;
    // }
    // if (/[\t \f\n]/.test(c)) {
    //   return beforeAttributeName;
    // }
    if (c === ">") {
      emitToken(token);
      return data;
    }
    if (/[a-zA-Z]/.test(c)) {
      token.name += c.toLowerCase();
      return tagName;
    }
  }
  // function selfClosingTag(c) {
  //   if (c === ">") {
  //     emitToken(token);
  //     endToken = new EndTagToken();
  //     endToken.name = token.name;
  //     emitToken(endToken);
  //     return data;
  //   }
  // }
  function endTagOpen(c) {
    if (/[a-zA-Z]/.test(c)) {
      token = new EndTagToken();
      token.name = c.toLowerCase();
      return tagName;
    }
    if (c === ">") {
      return error(c);
    }
  }

  function emitToken(token) {
    console.info({token})
    syntaxer.receiveInput(token);
  }
  function error(c) {
    console.log(`warn: unexpected char '${c}'`);
  }
}


class StartTagToken {}

class EndTagToken {}

class Attribute {}
