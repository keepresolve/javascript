import cTransfer from "../pkg/transfer/index";
import cTransferPage from "../pkg/transfer/page";
let components = [cTransfer,cTransferPage];

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

export {
  cTransfer,
 
}
export default {
  version:"1.0",
  install,
  cTransfer,
  cTransferPage
};
