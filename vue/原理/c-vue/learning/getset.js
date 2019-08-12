let Vue = {};
let configDef = {};
let config = {
  pig: 12312
};
configDef.get = () => {
  console.log(12312);
  return config;
};
configDef.set = () => {
  console.warn(
    "Do not replace the Vue.config object, set individual fields instead."
  );
};

Object.defineProperty(Vue, "config", configDef);
Vue.config = {};
