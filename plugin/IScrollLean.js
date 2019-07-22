function IScroll(el, options) {
  this.wrapper = typeof el == "string" ? doc.querySelector(el) : el;
  this.scroller = this.wrapper.children[0];
  this.scrollerStyle = this.scroller.style;
  this.options = {
    resizeScrollbars: true,
    mouseWheelSpeed: 20,
    snapThreshold: 0.334,
    // disablePointer : !utils.hasPointer,
    // disableTouch : utils.hasPointer || !utils.hasTouch,
    // disableMouse : utils.hasPointer || utils.hasTouch,
    startX: 0,
    startY: 0,
    scrollY: true,
    directionLockThreshold: 5,
    momentum: true,

    bounce: true,
    bounceTime: 600,
    bounceEasing: "",

    preventDefault: true,
    preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT)$/ },

    HWCompositing: true,
    useTransition: true,
    useTransform: true,
    bindToWrapper: typeof window.onmousedown === "undefined"
  };
  for (var i in options) {
    this.options[i] = options[i];
  }
  this.translateZ =
    this.options.HWCompositing && utils.hasPerspective ? " translateZ(0)" : "";

  this.options.useTransition =
    utils.hasTransition && this.options.useTransition;
  this.options.useTransform = utils.hasTransform && this.options.useTransform;

  this.options.eventPassthrough =
    this.options.eventPassthrough === true
      ? "vertical"
      : this.options.eventPassthrough;
  this.options.preventDefault =
    !this.options.eventPassthrough && this.options.preventDefault;

  // If you want eventPassthrough I have to lock one of the axes
  this.options.scrollY =
    this.options.eventPassthrough == "vertical" ? false : this.options.scrollY;
  this.options.scrollX =
    this.options.eventPassthrough == "horizontal"
      ? false
      : this.options.scrollX;

  // With eventPassthrough we also need lockDirection mechanism
  this.options.freeScroll =
    this.options.freeScroll && !this.options.eventPassthrough;
  this.options.directionLockThreshold = this.options.eventPassthrough
    ? 0
    : this.options.directionLockThreshold;

  this.options.bounceEasing =
    typeof this.options.bounceEasing == "string"
      ? utils.ease[this.options.bounceEasing] || utils.ease.circular
      : this.options.bounceEasing;

  this.options.resizePolling =
    this.options.resizePolling === undefined ? 60 : this.options.resizePolling;

  if (this.options.tap === true) {
    this.options.tap = "tap";
  }
  if (!this.options.useTransition && !this.options.useTransform) {
    if (!/relative|absolute/i.test(this.scrollerStyle.position)) {
      this.scrollerStyle.position = "relative";
    }
  }

  if (this.options.shrinkScrollbars == "scale") {
    this.options.useTransition = false;
  }

  this.options.invertWheelDirection = this.options.invertWheelDirection
    ? -1
    : 1;
  // Some defaults
  this.x = 0;
  this.y = 0;
  this.directionX = 0;
  this.directionY = 0;
  this._events = {};
}

var utils = (function() {
  return {
    addEvent: function(el, type, fn, capture) {
      el.addEventListener(type, fn, !!capture);
    },
    removeEvent: function(el, type, fn, capture) {
      el.removeEventListener(type, fn, !!capture);
    }
  };
})();
IScroll.prototype = {
  _init: function() {
    this._initEvents();
    if (this.options.scrollbars || this.options.indicators) {
      this._initIndicators();
    }
  },
  /**
   * @params remove 是否销毁
   */
  _initEvents(remove) {
    var eventType = remove ? utils.removeEvent : utils.addEvent,
      target = this.options.bindToWrapper ? this.wrapper : window; // ？？？？
    eventType(window, "orientationchange", this);
    eventType(window, "resize", this); //？？？？
    if (this.options.click) {
      eventType(this.wrapper, "click", this, true); //？？？
      if (!this.options.disableMouse) {
        eventType(this.wrapper, "mousedown", this); //？？？
        eventType(target, "mousemove", this);
        eventType(target, "mousecancel", this);
        eventType(target, "mouseup", this);
      }
      if (utils.hasPointer && !this.options.disablePointer) {
        eventType(this.wrapper, utils.prefixPointerEvent("pointerdown"), this);
        eventType(target, utils.prefixPointerEvent("pointermove"), this);
        eventType(target, utils.prefixPointerEvent("pointercancel"), this);
        eventType(target, utils.prefixPointerEvent("pointerup"), this);
      }

      if (utils.hasTouch && !this.options.disableTouch) {
        eventType(this.wrapper, "touchstart", this);
        eventType(target, "touchmove", this);
        eventType(target, "touchcancel", this);
        eventType(target, "touchend", this);
      }

      eventType(this.scroller, "transitionend", this);
      eventType(this.scroller, "webkitTransitionEnd", this);
      eventType(this.scroller, "oTransitionEnd", this);
      eventType(this.scroller, "MSTransitionEnd", this);
    }
  }
};
