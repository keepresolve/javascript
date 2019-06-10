import ElInput from './src/input';

/* istanbul ignore next */
ElInput.install = function(Vue) {
  console.log("input installed")
  Vue.component(ElInput.name, ElInput);
};

export default ElInput;
