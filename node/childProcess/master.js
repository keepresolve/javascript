const fs = require("fs");
const child_process = require("child_process");

for (var i = 0; i < 2; i++) {
  var workerProcess = child_process.exec("node support.js " + i, function(
    error,
    stdout,
    stderr
  ) {
    if (error) {
      console.log(error.stack);
      console.log("Error code: " + error.code);
      console.log("Signal received: " + error.signal);
    }
    console.log("stdout: " + stdout);
    console.log("stderr: " + stderr);
  });

  workerProcess.on("exit", function(code) {
    console.log("子进程已退出，退出码 " + code);
  });
}
// npm install "http-server
// child_process
//   .exec("http-server -o", function(error, stdout, stderr) {
//     if (error) {
//       console.log(error.stack);
//       console.log("Error code: " + error.code);
//       console.log("Signal received: " + error.signal);
//     }
//     console.log("stdout: " + stdout);
//     console.log("stderr: " + stderr);
//   })
//   .on("exit", function(code) {
//     console.log("子进程已退出，退出码 " + code);
//   });

let child = child_process.spawn("ls", ["-lh", "/usr"]);
child.stdout.setEncoding("utf8");
child.stdout.on("data", function(data) {
  console.log(data);
});
