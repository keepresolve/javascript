class Event {
  constructor() {
    this.handler = {
      event: [
        function() {
          console.log("this is a explame");
        }
      ]
    };
  }
  $on(type, fn) {
    if (!this.handler[type]) this.handler[type] = [];
    this.handler[type].push(fn);
  }
  $emit(type) {
    let fns = this.handler[type];
    let arg = Array.from(arguments).slice(1);
    if (fns) {
      fns.forEach(fn => {
        fn(arg);
      });
    }
  }
  $removeOne(type, fn) {
    let fns = this.handler[type];
    if (!fns) return;
    let index = fns.findIndex(v => v == fn);
    if (index != -1) fns.splice(index, 1);
  }
  $removeAll(type) {
    let fns = this.handler[type];
    if (!fns) return;
    fns = [];
  }
  $removeAllHanlder() {
    this.handler = {
      event: [
        function() {
          console.log("this is a explame");
        }
      ]
    };
  }
}

let obj = new Event();
obj.$on("add", function() {
  console.log(arguments);
});
obj.$emit("add", 1, 23, 4, 5, 5);
