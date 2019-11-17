import wx from "sdk-wechat.js";
// 小程序环境
wx.miniProgramPromise = _ =>
  new Promise(resolve => {
    if (/miniProgram/.test(window.navigator.userAgent)) {
      // 微信7.0.0开始，可以通过判断userAgent中包含miniProgram字样来判断小程序web-view环境。
      resolve(true);
    }

    var ua = window.navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == "micromessenger") {
      //判断是否是微信环境
      //微信环境
      wx.miniProgram.getEnv(function(res) {
        if (res.miniprogram) {
          // 小程序环境下逻辑
          resolve(true);
        } else {
          resolve(false);
          //非小程序环境下逻辑
        }
      });
    } else {
      resolve(false);
      //非微信环境逻辑
    }
  });
