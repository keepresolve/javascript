let events = require("events");
const EventEmitter = events.EventEmitter;

class Events extends EventEmitter {
  constructor() {
    super();
    this.on("add2", function() {
      console.log("add2", arguments);
    });
  }
}

let obj = new Events();
obj.on("add", function() {
  console.log(arguments);
});
obj.emit("add", 123123);
obj.emit("add2", 123123);
