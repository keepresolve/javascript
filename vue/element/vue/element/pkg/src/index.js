import cTransfer from "../pkg/transfer/index";

let components = [cTransfer];

const install = function(Vue, opts = {}) {
  console.log({ Vue });
  components.forEach(component => {
    Vue.component(component.name, component);
  });
};

/* istanbul ignore if */
if (typeof window !== "undefined" && window.Vue) {
  install(window.Vue);
}

export default {
  install,
  cTransfer
};
