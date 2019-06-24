import selectTree from "./main.vue";

/* istanbul ignore next */
selectTree.install = function(Vue) {
  Vue.component(selectTree.name, selectTree);
};

export default selectTree;
