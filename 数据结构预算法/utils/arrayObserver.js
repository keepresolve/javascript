
function watchArray(arr, cb) {
    this.$cb = cb || function () { }
    var arrayProto = arr.prototype;
    this.arr = arr
    var arrayMethods = Object.create(arrayProto);
    // 重写了数组方法  监听
    ["push", "pop", "shift", "unshift", "splice", "sort", "reverse"].forEach(
        function (method) {
            // 使用 Object.defineProperty 进行监听
            Object.defineProperty(arrayMethods, method, {
                value: function testValue() {
                    const original = arrayProto[method];
                    // 使类数组变成一个真正的数组
                    const args = Array.from(arguments);
                    original.apply(this, args);
                }
            });
        }
    );
}
watchArray.prototype = {
    observer(target, key, value) {
        Object.defineProperty(target, key, {
            get() {
                this.$cb("get", value)
                return value
            },
            set() {
                this.$cb("set", val)
                value = val
            }
        })
    }
}