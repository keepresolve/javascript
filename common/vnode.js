(function(global, factory) {
  typeof exports === "object" && typeof module !== "undefined"
    ? (module.exports = factory())
    : typeof define === "function" && define.amd
    ? define(factory)
    : ((global = global || self), (global.util = factory()));
})(this, function() {
  "use strict";

  function vNode(tagName, props, children) {
    if (!(this instanceof vNode)) return new vNode(...arguments);
    this.tagName = tagName;
    this.props = props || {};
    this.children = children || [];
    this.key = props ? props.key : undefined;
    let count = 0; //所有子元素计数

    this.children.forEach(child => {
      if (child instanceof vNode) {
        count += child.count; //标签元素
      }
      count++; //如果是文本元素
    });
    this.count = count;
  }

  function setAttr(node, key, value) {
    // console.log({ node, key, value });
    switch (key) {
      case "style":
        node.style = value;
        // node.style.cssText = value;
        break;
      case "value":
        let tagName = node.tagName;
        if (
          tagName == "input" ||
          tagName == "textarea" ||
          tagName == "button"
        ) {
          node.value = value;
        } else {
          node.setAttribute(key, value);
        }
        break;
      default:
        node.setAttribute(key, value);
        break;
    }
  }

  vNode.prototype.render = function() {
    let dom = document.createElement(this.tagName);
    let children = this.children;
    for (let key in this.props) {
      setAttr(dom, key, this.props[key]);
    }
    children.forEach(child => {
      var el =
        child instanceof vNode
          ? child.render()
          : document.createTextNode(child);
      dom.append(el);
    });
    return dom;
  };
  if (!window.vNode) window.vNode = vNode;
  return {
    vNode: vNode
  };
});
