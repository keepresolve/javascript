function validate(binding) {
  if (!binding.value) return false;
  if (typeof binding.value !== "function") {
    console.warn(
      "[vue-through:] provided expression, bind.expression, is not a function"
    );
    return false;
  }
  return true;
}
function getStyle(element, attr) {
  if (window.getComputedStyle) {
    return attr
      ? window.getComputedStyle(element, null)[attr]
      : window.getComputedStyle(element, null);
  }
  return attr ? element.currentStyle[attr] : element.currentStyle;
}
export let through = {
  name: "through",
  installed: false,
  bind(el, binding, vnode, oldVnode) {
    el.__vueThrough__ = {
      isCall: validate(binding)
    };
    if (el.__vueThrough__.isCall) {
      binding.value("bind", { el, context: vnode.context });
    }
  },
  inserted(el, binding, vnode, oldVnode) {
    let oldStyle = getStyle(el);
    el.__vueThrough__.oldStyle = {
      position: oldStyle.position,
      border: oldStyle.border,
      bottom: oldStyle.bottom,
      // height: react.height + "px",
      left: oldStyle.left,
      right: oldStyle.right,
      top: oldStyle.top,
      width: oldStyle.width
    };
    el.__vueThrough__.react = el.getBoundingClientRect();
    if (el.__vueThrough__.isCall) {
      binding.value("inserted", { el, context: vnode.context });
    }
  },
  update(el, binding, vnode, oldVnode) {
    if (el.__vueThrough__.isCall) {
      binding.value("update", { el, context: vnode.context });
    }
  },
  componentUpdated(el, binding, vnode, oldVnode) {
    let arg = binding.arg ? binding.arg.split(":") : [],
      __vueThrough__ = el.__vueThrough__,
      context = vnode.context,
      react = __vueThrough__.react,
      oldStyle = __vueThrough__.oldStyle,
      isOpen = arg.find(key => context[key]);

    __vueThrough__.isOpen = isOpen;
    let OStyle = {
      position: oldStyle.position,
      border: oldStyle.border,
      bottom: oldStyle.bottom,
      // height: react.height + "px",
      left: oldStyle.left,
      right: oldStyle.right,
      top: oldStyle.top,
      width: oldStyle.width
    };
    if (isOpen) {
      OStyle = {
        position: "fixed",
        // border: "1px solid red",
        bottom: react.bottom + "px",
        // height: react.height + "px",
        left: react.left + "px",
        right: react.right + "px",
        top: react.top + "px",
        width: react.width + "px"
      };
    }
    if (el.__vueThrough__.isCall) {
      let getStyle = binding.value("componentUpdated", {
        el,
        context: vnode.context
      });
      if (
        Object.prototype.toString.call(getStyle) == "[object Object]" &&
        isOpen
      ) {
        Object.assign(OStyle, getStyle);
      }
    }
    Object.assign(el.style, OStyle);
  },
  unbind(el, binding, vnode, oldVnode) {
    if (el.__vueThrough__.isCall) {
      binding.value("unbind", {
        el,
        binding,
        vnode,
        oldVnode
      });
    }
  }
};
