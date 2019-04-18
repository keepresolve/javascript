// 事件注册
// (function() {
//   var emitEvent = {
//     eventName: [
//       "EM_EVENT_INITIALIZE",
//       "EM_EVENT_SIGNIN",
//       "EM_CALLEVENT_CALLINCOMING"
//     ],
//     customName: ["init", "login", "callIn"],

//     on: function(eventName, callback) {
//       if (!this.handles) {
//         this.handles = {};
//         Object.defineProperty(this, "handles", {
//           value: {},
//           enumerable: false,
//           configurable: true,
//           writable: true
//         });
//       }
//       console.info("register event", eventName);
//       eventName = this.eventName[this.customName.indexOf(eventName)];
//       if (!eventName) return console.warn("event is not defind", eventName);
//       if (!this.handles[eventName]) {
//         this.handles[eventName] = [];
//       }
//       this.handles[eventName].push(callback);
//     },
//     emit: function() {
//       if (this.handles[arguments[0]]) {
//         for (var i = 0; i < this.handles[arguments[0]].length; i++) {
//           this.handles[arguments[0]][i](arguments[1]);
//         }
//       }
//     }
//   };
//   //对外实例
//   var BCCSDK = {
//     init: function(ip, prot, apId, secretKey, extension, password) {
//       emitEvent.on("init", function(xjson) {
//         //初始化失败
//         if (xjson.Result != "0") {
//           alert(xjson.Info);
//         }
//       });
//     },

//     //注册事件通知
//     /**
//      *
//      * @param {*来电通知} callIn
//      * @param {*状态变化通知} stateChange
//      * @param {*挂断通知} hangup
//      */
//     register: function(event) {
//       if (!event) return console.error("参数能为空");
//       for (var e in event) {
//         emitEvent.on(e, event[e]);
//       }
//     },
//     // 登陆
//     /**
//      *
//      * @param {*} eventname             //签入方法（必选）
//      * @param {*} switchnumber          //总机号码（必选）
//      * @param {*} seatnumbe             //座席分机号（必选）
//      * @param {*} password              //密码（必选）
//      * @param {*} devicenumber          //回拨设备号码（回拨模式必选)
//      * @param {*} sipphonenumber        //Sip话机号码（sip模式必选)
//      * @param {*} intranetaddress       //专网运维地址（专线模式必选）
//      * @param {*} callmode              //呼叫模式（0：回拨话机模式 1：VOIP 2：SIP话机模式）（必选）
//      * @param {*} intranetmode          //网络模式（0：常规 公网 1：专网）（必选）
//      * @param {*} onlinestatus          //预设状态（0：空闲 1：忙碌）（必选）
//      */
//     login: function(cb) {
//       objOCX.SDKFunction(
//         "SignIn",
//         "02566699734",
//         "1051",
//         "1051",
//         "",
//         "",
//         "",
//         "1",
//         "0",
//         "0"
//       );
//       emitEvent.on("login", cb);
//     }
//   };
//   if (!window.BCCSDK) window.BCCSDK = BCCSDK;
//   if (!window.BCCSDKCallBack) window.BCCSDKCallBack = callBack;
//   function callBack(eventName, paras) {
//     console.info("result", eventName, paras);
//     var xjson = {};
//     try {
//       xjson = JSON.parse(paras);
//       xjson.code = xjson.Result;

//       emitEvent.emit(eventName, xjson);
//       switch (eventName) {
//         case "EM_EVENT_INITIALIZE": //页面初始化的回调
//           if (xjson.Result != "0") {
//             //初始化失败
//             alert(xjson.Info);
//           }
//           break;
//         case "EM_EVENT_SIGNIN": //点击登录按钮后的回调
//           if (xjson.Result == "0") {
//             alert(xjson);
//             //登录成功
//           } //登录不成功
//           else {
//             alert(xjson.Info);
//           }
//           break;
//         case "EM_CALLEVENT_CALLINCOMING": //呼入震铃
//           if (xjson.Result == "0") {
//             alert(xjson);
//             //登录成功
//           } //登录不成功
//           else {
//             alert(xjson.Info);
//           }
//           break;
//       }
//     } catch (error) {
//       console.error(error);
//       xjson = {
//         code: 500
//       };
//     }
//   }
// })(window);

let arrary = [1, 2, 3];
// function cut(arr, num) {
//   let result = [];
//   for (let i = 0; i < arr.length; i += num) {
//     result.push(arr.slice(i, i + num).join(""));
//   }
//   return result;
// }

// console.log(cut(arrary, 3));
// let result = [];

// for (let i = 0; i < arrary.length; i++) {
//   for (let index = 0; index < arrary.length; index++) {
//     for (let j = 0; j < arrary.length; j++) {
//       result.push(arrary[i] + "" + arrary[index] + "" + arrary[j]);
//     }
//   }
// }

// console.log(result);
