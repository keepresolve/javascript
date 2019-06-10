import directive from './src/directive';
import service from './src/index';

export default {
  install(Vue) {
    console.log("loading install")
    Vue.use(directive);
    Vue.prototype.$loading = service;
  },
  directive,
  service
};
