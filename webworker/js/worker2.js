setInterval(() => {
  self.postMessage({ type: "custom", msg: "自定义" });
}, 1000);
