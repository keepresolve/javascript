import cTransfer from "./main.vue";

/* istanbul ignore next */
cTransfer.install = function(Vue) {
  console.log("cTransfer install")
  Vue.component(cTransfer.name, cTransfer);
};

export default cTransfer;

    
// import ElInput from './src/input';

// /* istanbul ignore next */
// ElInput.install = function(Vue) {
//   Vue.component(ElInput.name, ElInput);
// };

// export default ElInput;