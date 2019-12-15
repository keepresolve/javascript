
interface options {
    el: string | HTMLElement
}
interface hooks{
    breforInit:Object,
    init:Object,
    update:Object,
    beforeDestroy:Object,
    destroy:Object
}
function getType(type:any) {
    return   Object.prototype.toString.call(type)
}
let hooks:hooks={
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
}
class Iscroll {
    //私有属性
    private options: {
        el: string | HTMLElement,
        children: HTMLElement
    }
    private hooks: Object
    constructor(options: options) {
        this.hooks=hooks
        this.options = { ...this.options, ...options }
        this.options.el= typeof this.options.el =="string" ? document.querySelector(this.options.el):this.options.el
        // console.log(th)
    }
    public getOption() {
        return this.options
    }
    public setOption(options: options) {
        this.options = { ...this.options, ...options }
        this.refresh()
    }
    public refresh() {

    }
    init() {
        this.emit("breforInit")
        
        this.emit("init")
    }
    on(eventType: string, cb: Function) {
        return this.hooks[eventType] && this.hooks[eventType].callbacks.push(cb)
    }
    unbind(eventType: string, cb: Function) {
        let callbacks = this.hooks[eventType].callbacks
        if (cb) {
            let index = callbacks.findIndex(fn => fn == cb)
            callbacks.splice(index, 1)
        } else {
            this.hooks[eventType].callbacks = []
        }

    }
    emit(eventType: string) {
        let  arg =arguments
        this.hooks[eventType].callbacks.forEach(cb => cb.apply(this,arg));
    }

    // public rAF = window.requestAnimationFrame	||  // requestAnimationFrame 支持动画渲染完毕 最佳性能体验
    // window.webkitRequestAnimationFrame	||  
    // window.mozRequestAnimationFrame		||
    // window.oRequestAnimationFrame		||
    // window.msRequestAnimationFrame		||
    // function (callback) { window.setTimeout(callback, 1000 / 60); }
}
let instance = new Iscroll({ el: "string" })
instance.on("breforInit", function () {
    console.log("breforInit", arguments, this)
})
setTimeout(() => {
    instance.init()
}, 2000);
let options = instance.getOption()
console.log({ options, opt: instance.getOption() })