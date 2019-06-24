import cTransfer from "./main.vue";

/* istanbul ignore next */
cTransfer.install = function(Vue) {
  console.log("cTransfer install")
  Vue.component(cTransfer.name, cTransfer);
};

export default cTransfer;

//el-checkbox-group
// el-checkbox
// el-scrollbar