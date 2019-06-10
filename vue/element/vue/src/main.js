// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from "vue";
import App from "./App";
import router from "./router";
Vue.config.productionTip = false;
import el from "../element/src/index.js";
Vue.use(el);
import "element-ui/lib/theme-chalk/index.css";

import customEL from "../element/pkg/src/index.js";
Vue.use(customEL);
console.log({ customEL,el });
/* eslint-disable no-new */
let root = new Vue({
  el: "#app",
  router,
  components: { App },
  template: "<App/>"
});
console.log({root})