//;分号开头，用于防止代码压缩合并时与其它代码混在一起造成语法错误
//而事实证明，uglify压缩工具会将无意义的前置分号去掉，我只是习惯了这么写

//(function(){})();立即执行函数，闭包，避免污染全局变量
//通常一个插件只暴露一个变量给全局供其它程序调用
//还有其它写法，运算符+函数体+括号
//例：!function(){}(); +function(){}(); -function(){}();
//    void function(){}(); 等等只要能对函数返回值进行运算的符号都可以
(function(global) {
  //开启严格模式，规范代码，提高浏览器运行效率
  "use strict";

  //定义一个类，通常首字母大写
  var Element = function(tagName, props, children) {
    if (!(this instanceof Element)) {
      //如果非Element实例 自动实例化
      return new Element(tagName, props, children);
    }
    // [this.tagName, this.props, this.children] = [...arguments]
    // this.props.key = this.props ? this.props.key : undefined
    this.tagName = tagName;
    this.props = props || {};
    this.children = children || [];
    this.key = props ? props.key : undefined;

    let count = 0; //所有子元素计数
    this.children.forEach(child => {
      if (child instanceof Element) {
        count += child.count; //标签元素
      }
      count++; //如果是文本元素
    });
    this.count = count;
  };

  //覆写原型链，给继承者提供方法
  Element.prototype = {
    render: function() {
      const el = document.createElement(this.tagName);
      const props = this.props;
      const event = props.event || [];
      event.forEach(ev => {
        ev.fns.map(fn => {
          el.addEventListener(ev.type, fn);
        });
      });
      for (const propName in props) {
        this.setAttr(el, propName, props[propName]);
      }

      this.children.forEach(child => {
        const childEl =
          child instanceof Element
            ? child.render()
            : document.createTextNode(child);
        el.appendChild(childEl);
      });

      return el;
    },
    addEvent() {},
    // 属性设置
    setAttr(node, key, value) {
      switch (key) {
        case "style":
          node.style.cssText = value;
          break;
        case "value": {
          const tagName = node.tagName.toLowerCase() || "";
          if (
            (tagName === "input" || tagName === "textarea", tagName == "button")
          ) {
            node.value = value;
          } else {
            node.setAttribute(key, value);
          }
          break;
        }
        default:
          node.setAttribute(key, value);
          break;
      }
    }
  };

  //兼容CommonJs规范
  if (typeof module !== "undefined" && module.exports) module.exports = Element;

  //兼容AMD/CMD规范
  if (typeof define === "function")
    define(function() {
      return Element;
    });

  //注册全局变量，兼容直接使用script标签引入该插件
  global.Element = Element;

  //this，在浏览器环境指window，在nodejs环境指global
  //使用this而不直接用window/global是为了兼容浏览器端和服务端
  //将this传进函数体，使全局变量变为局部变量，可缩短函数访问全局变量的时间
})(this);
