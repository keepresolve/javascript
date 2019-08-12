import Vue from "./instance/index";
import { initGlobalAPI } from "./global-api/index";
import { isServerRendering } from "core/util/env";
import { FunctionalRenderContext } from "core/vdom/create-functional-component";
initGlobalAPI(Vue);

Object.defineProperty(Vue.prototype, "$isServer", {
  get: isServerRendering
});
Object.defineProperty(Vue.prototype, "$ssrContext", {
  get() {
    /* istanbul ignore next */
    return this.$vnode && this.$vnode.ssrContext;
  }
});
//为ssr运行时助手安装公开FunctionalRenderContex
Object.defineProperty(Vue, "FunctionalRenderContext", {
  value: FunctionalRenderContext
});
Vue.version = "__VERSION__";

export default Vue;
