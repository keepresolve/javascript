var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
function getType(type) {
    return Object.prototype.toString.call(type);
}
var hooks = {
    breforInit: {
        callbacks: []
    },
    init: {
        callbacks: []
    },
    update: {
        callbacks: []
    },
    beforeDestroy: {
        callbacks: []
    },
    destroy: {
        callbacks: []
    }
};
var Iscroll = /** @class */ (function () {
    function Iscroll(options) {
        this.hooks = hooks;
        this.options = __assign(__assign({}, this.options), options);
        this.options.el = typeof this.options.el == "string" ? document.querySelector(this.options.el) : this.options.el;
        // console.log(th)
    }
    Iscroll.prototype.getOption = function () {
        return this.options;
    };
    Iscroll.prototype.setOption = function (options) {
        this.options = __assign(__assign({}, this.options), options);
        this.refresh();
    };
    Iscroll.prototype.refresh = function () {
    };
    Iscroll.prototype.init = function () {
        this.emit("breforInit");
        this.emit("init");
    };
    Iscroll.prototype.on = function (eventType, cb) {
        return this.hooks[eventType] && this.hooks[eventType].callbacks.push(cb);
    };
    Iscroll.prototype.unbind = function (eventType, cb) {
        var callbacks = this.hooks[eventType].callbacks;
        if (cb) {
            var index = callbacks.findIndex(function (fn) { return fn == cb; });
            callbacks.splice(index, 1);
        }
        else {
            this.hooks[eventType].callbacks = [];
        }
    };
    Iscroll.prototype.emit = function (eventType) {
        var _this = this;
        var arg = arguments;
        this.hooks[eventType].callbacks.forEach(function (cb) { return cb.apply(_this, arg); });
    };
    return Iscroll;
}());
var instance = new Iscroll({ el: "string" });
instance.on("breforInit", function () {
    console.log("breforInit", arguments, this);
});
setTimeout(function () {
    instance.init();
}, 2000);
var options = instance.getOption();
console.log({ options: options, opt: instance.getOption() });
