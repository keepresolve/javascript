import page from "./page.vue";

/* istanbul ignore next */
page.install = function(Vue) {
//   console.log("page install")
  Vue.component(page.name, page);
};

export default page;
//el-checkbox-group
// el-checkbox
// el-scrollbar