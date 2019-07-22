function Vue(options) {
  let data = options.data || {};
  let el = options.el;
  let render =
    options.render ||
    function() {
      return document.createElement("div");
    };
  this.dom = render(data, vNode);
  console.log({ vNodes: this.dom });
  console.log(11, this);
  this.$mount(el);
  return this;
}
Vue.prototype.$mount = function(el) {
  el = el instanceof HTMLElement ? el : document.querySelector(el);
  if (el) {
    el.appendChild(this.dom);
  }
};
