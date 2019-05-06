// for (let i of new Array(10)) {
//   let result = await new Promise(res => {
//     if (that.isBreak) return res({ code: 200 });
//     setTimeout(() => {
//       res(this.$api.get("/modifyEp"));
//     }, 500);
//   });
//   if (this.isBreak) break;
//   console.log(result);
// }

// function Observer(data, option) {
//   this.data = data;
//   const augment = value.__proto__ ? protoAugment : copyAugment;
//   augment(value, arrayMethods, key);
//   // 兼容不支持 __proto__的方法
//   function protoAugment(target, src) {
//     target.__proto__ = src;
//   }
//   // 不支持 __proto__的直接修改先关的属性方法
//   function copyAugment(target, src, keys) {
//     for (let i = 0, l = keys.length; i < l; i++) {
//       const key = keys[i];
//       def(target, key, src[key]);
//     }
//   }
// }
// var P = Observer.prototype;
// var ArrayProto = Array.prototype; // 获取数组原型
// var ArrayMethods = Object.create(ArrayProto); //依数组原型创建对象
// //重写这几个方法 并劫持
// ArrayMethods.aaa = 123;
// ["push", "pop", "shift", "unshift", "splice", "sort", "reverse"].forEach(
//   function(method) {
//     // https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty
//     Object.defineProperty(ArrayMethods, method, {
//       //  value  该属性对应的值。可以是任何有效的 JavaScript 值（数值，对象，函数等）。默认为 undefined
//       //  设置默认值 method 进行重写
//       value: function() {
//         console.log(this);
//         const original = arrayProto[method];
//         // 传进来的参数
//         const args = Array.from(arguments); // 使类数组变成一个真正的数组
//         original.apply(this, args);
//       }
//     });
//   }
// );

// var g = [
//   { type: "sug", sa: "s_1", q: "大唐荣耀" },
//   { type: "sug", sa: "s_2", q: "大唐芙蓉园" },
//   { type: "sug", sa: "s_3", q: "大淘客" },
//   { type: "sug", sa: "s_4", q: "大唐双龙传" },
//   { type: "sug", sa: "s_5", q: "大唐电信" },
//   { type: "sug", sa: "s_6", q: "大逃脱" },
//   { type: "sug", sa: "s_7", q: "打胎" },
//   { type: "sug", sa: "s_8", q: "大唐好相公" },
//   { type: "sug", sa: "s_9", q: "大唐荣耀1" },
//   { type: "sug", sa: "s_10", q: "大唐官" }
// ];
// new Observer(g);

// g.push({ aa: 123312 });

//数组截取
let arrary = [1, 2, 3, 4, 5, 6, 7, 8, 3, 8, 9, 1];
function cut(arr, num) {
  let result = [];
  for (let i = 0; i < arr.length; i += num) {
    result.push(arr.slice(i, i + num).join(""));
  }
  return result;
// ajax
// 随机字符串位数
function randomString(len) {
  len = len || 32;
  var $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  var maxPos = $chars.length;
  var pwd = "";
  for (var i = 0; i < len; i++) {
    pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
  }
  return pwd;
}

/**
 *基于axios
 * @param {*请求方法} method
 * @param {*地址} url
 * @param {*参数} param
 * @param {*请求头部} headerObj
 */
let requestArr = new Map(); //存储请求
let delay = 300; //300毫秒内只请求一次
const gdRequest = (method, url, param, headerObj) => {
  return new Promise(res => {
    let key = JSON.stringify({
      method,
      url,
      param
    }).toLowerCase();
    let timer = null;
    if (requestArr.has(key)) {
      // console.warn("300ms内连续请求 只请求一次")
      clearTimeout(requestArr.get(key));
      timer = setTimeout(() => {
        res(
          axios({
            method: method || "GET",
            url,
            params: param,
            headers: headerObj || {
              source: "",
              token: "",
              nonce: randomString(32)
            }
          }).catch(err => {
            console.error(`请求出错接口${url}`, err.message);
            err.data = {
              code: 9999,
              info: "网络出错"
            };
            return err;
          })
        );
      }, dalay);
    } else {
      timer = setTimeout(() => {
        res(
          axios({
            method: method || "GET",
            url,
            params: param,
            headers: headerObj || {
              source: "client.web",
              token: sessionStorage.getItem("user-token"),
              nonce: randomString(32)
            }
          }).catch(err => {
            console.error(`请求出错接口${url}`, err.message);
            err.data = {
              //后台返回数据可能通用2层data
              code: 9999,
              info: "网络出错"
            };
            return err;
          })
        );
      }, 0);
    }
    requestArr.set(key, timer);
  });
};

// ES6 code
function throttled(delay, fn) {
  let lastCall = 0;
  return function (...args) {
    const now = (new Date).getTime();
    if (now - lastCall < delay) {
      return;
    }
    lastCall = now;
    return fn(...args);
  }
}
// ES6
function debounced(delay, fn) {
  let timerId;
  return function (...args) {
    if (timerId) {
      clearTimeout(timerId);
    }
    timerId = setTimeout(() => {
      fn(...args);
      timerId = null;
    }, delay);
  }
}
//aduio 加载成功播放
var audio = document.createElement("audio");
/**
 * promise  cb
 * @param {*} option  url加载地址
 * @param {*} cb
 */
function play(option, cb) {
  return new Promise(res => {
    audio = document.createElement("audio");
    audio.src = option.url;
    audio.load && audio.load();
    audio.oncanplaythrough = function() {
      audio.play();
      cb && cb({ code: 200, info: "播放成功", option });
      res({ code: 200, info: "播放成功", option });
    };
    audio.onerror = function(error) {
      cb && cb({ code: 500, info: "音频加载失败", error, option });
      res({ code: 500, info: "音频加载失败", error, option });
    };
  });
}
// 递归等结果
/**
 * pormise  callback
 * @param {*} id
 * @param {*} options  配置
 * @param {*} cb
 */
async function forwardAsync(id, options, cb) {
  let option = {
    currentPath: "", //当前
    delay: 500, //递归拿到上一次结果多长时间请求再次
    forwardTimes: 15, //请求次数
    isplay: true, // 是否播放
    requestUrl: `/ivr/voice/${id}` //请求地址
  };

  let isSuccess = false;
  let errorData = {
    info: "获取失败",
    code: 500,
    option
  };
  Object.assign(option, options);
  return new Promise(async res => {
    for (let times of new Array(option.forwardTimes)) {
      let result = await new Promise(res =>
        setTimeout(() => {
          res(gdRequest("GET", option.requestUrl));
        }, option.delay)
      );
      if (result.data.code == 200) {
        if (result.data.data.voice.status != 0) {
          console.log("获取语音成功");
          Object.assign(option, {
            data: result.data.data,
            url: result.data.data.download_url
          });
          if (option.isplay) {
            play(option, playResult => {
              cb && cb(playResult);
              res(playResult);
            });
          } else {
            cb && cb({ code: 200, info: "获取语音成功", option });
            res({ code: 200, info: "获取语音成功", option });
          }
          isSuccess = true;
          break;
        }
      }
      if (isSuccess) break;

      let currentPath = location.href.split("/").pop();
      // console.log("当前二级路由:"+currentPath)
      if (option.currentPath && currentPath != option.currentPath) {
        errorData.code = 301;
        errorData.info = "获取录音文件终止";
        break;
      }
    }

    if (!isSuccess) {
      // this.$message.warning('语音生成超时失败')
      cb && cb(errorData);
      res(errorData);
    }
  });
}

// XML——————————————————————————————————————————————————————————————————————————————————————————————————
/**input file */
function readFile(uploadFiles) {
  try {
    for (let i = 0; i < uploadFiles.length; i++) {
      let file = uploadFiles[i];
      // console.log(file.raw)
      if (!file) continue;
      if (!file.raw.type.match(/text\/xml/)) {
        this.$message.warning("只能上传xml格式的文件");
        uploadFiles.splice(i, 1);
        continue;
      }
      let reader = new FileReader();
      reader.onload = async e => {
        this.uploadXML = e.target.result; //获取文件内容
        this.$refs.codeIvrProcess.save(e.target.result);
      };
      reader.readAsText(file.raw);
    }
  } catch (error) {
    this.$message.error(error.message);
  }
}
// 格式化XML
function formatXml(xml, tab) {
  //格式化xml文件
  var formatted = "",
    indent = "";
  tab = tab || "\t";
  xml.split(/>\s*</).forEach(function(node) {
    if (node.match(/^\/\w/)) indent = indent.substring(tab.length);
    formatted += indent + "<" + node + ">\r\n";
    if (node.match(/^<?\w[^>]*[^\/]$/)) indent += tab;
  });
  return formatted.substring(1, formatted.length - 3);
}
//验证XML
function validateXML(xmlContent) {
  //errorCode 0是xml正确，1是xml错误，2是无法验证
  var xmlDoc,
    errorMessage,
    errorCode = 0;
  // code for IE
  if (window.ActiveXObject) {
    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async = "false";
    xmlDoc.loadXML(xmlContent);

    if (xmlDoc.parseError.errorCode != 0) {
      errorMessage = "错误code: " + xmlDoc.parseError.errorCode + "\n";
      errorMessage = errorMessage + "错误原因: " + xmlDoc.parseError.reason;
      errorMessage = errorMessage + "错误位置: " + xmlDoc.parseError.line;
      errorCode = 1;
    } else {
      errorMessage = "格式正确";
    }
  }
  // code for Mozilla, Firefox, Opera, chrome, safari,etc.asd
  else if (document.implementation.createDocument) {
    var parser = new DOMParser();
    xmlDoc = parser.parseFromString(xmlContent, "text/xml");
    var error = xmlDoc.getElementsByTagName("parsererror");
    if (error.length > 0) {
      if (xmlDoc.documentElement.nodeName == "parsererror") {
        errorCode = 1;
        errorMessage = xmlDoc.documentElement.childNodes[0].nodeValue;
      } else {
        errorCode = 1;
        errorMessage = xmlDoc.getElementsByTagName("parsererror")[0]
          .textContent;
      }
    } else {
      errorMessage = "格式正确";
    }
  } else {
    errorCode = 2;
    errorMessage = "浏览器不支持验证，无法验证xml正确性";
  }
  return {
    msg: errorMessage,
    error_code: errorCode
  };
}

// 获取当前元素的位置getBoundingClientRect
function proverClick(el, binding, vnode) {
  // console.log({el,binding,vnode})
  /** el可以获取当前dom节点，并且进行编译，也可以操作事件 **/
  /** binding指的是一个对象，一般不用 **/
  /** vnode 是 Vue 编译生成的虚拟节点 **/
  //得到dom元素的矩形，这个方法很好用
  let config = binding.value;

  el.addEventListener("click", function(event) {
    let pover = document.querySelector("#testDialog");
    var rect = el.getBoundingClientRect();
    //得到dom元素的宽高，ie8-不支持rect.width,rect.height
    var basew = rect.right - rect.left;
    var baseh = rect.bottom - rect.top;
    //得到浏览器的客户区宽高
    var docw = document.documentElement.clientWidth;
    var doch = document.documentElement.clientHeight;

    //判断dom元素的左边空间大还是右边空间大
    var isleft = docw - rect.left < rect.right ? true : false;
    //判断dom元素的上边空间大还是下面空间大
    var istop = doch - rect.bottom < rect.top ? true : false;

    //得到页面的滚动高度。
    var scrollw = Math.max(
      document.documentElement.scrollWidth,
      document.body.scrollWidth
    );
    //得到div的宽高
    var drect = pover.getBoundingClientRect();
    var dw = drect.right - drect.left;
    var dh = drect.bottom - drect.top;

    //先判断div跟input是左对齐还是右对齐
    //div宽度大于右边的宽度，并且左边空间比右边大时是右对齐
    //判断是用right还是left定位
    var loc_isright = dw > docw - rect.left && isleft ? true : false;

    //定位的数值大小
    var left = dw > docw - rect.left && isleft ? rect.right : rect.left;

    //判断div是否超出客户区空间大小，需要加宽度
    var ismax = dw > docw - rect.left && dw > rect.right ? true : false;
    var max_w;

    //如果需要计算最大宽度
    if (ismax) {
      max_w = docw - rect.left > rect.right ? docw - rect.left : rect.right;
    }

    //如果div小于input的宽度采用input的宽度
    var ismin = dw < basew;
    if (ismin) {
      max_w = basew;
    }

    //判断上下的位置
    //采用top，因为相对于body定位bottom的位置跟body是否有relative相关
    var top =
      dh > doch - rect.bottom && istop
        ? rect.top > dh
          ? rect.top - dh
          : 0
        : rect.bottom;

    //是否需要最大高度
    var ismax_h = dh > doch - rect.bottom && dh > rect.top ? true : false;
    var max_h;

    //计算最大高度
    if (ismax_h) {
      max_h = doch - rect.bottom > rect.top ? doch - rect.bottom : rect.top;
    }
    //得到滚动条的位置。
    var scrollTop =
      document.documentElement.scrollTop ||
      window.pageYOffset ||
      document.body.scrollTop;
    var scrollLeft =
      document.documentElement.scrollLeft ||
      window.pageXOffset ||
      document.body.scrollLeft;

    //设置左右的位置
    if (loc_isright) {
      //先清空left定位再设置right
      pover.style.left = "";

      pover.style.right = scrollw - (left + scrollLeft) + "px";
    } else {
      pover.style.left = left + scrollLeft + "px";
    }
    //设置top的定位
    pover.style.top = top + scrollTop + "px";

    //设置宽度
    if (ismax || ismin) {
      pover.style.width = max_w + "px";
      if (ismax) {
        pover.style.overflowX = "auto";
      }
    }
    //设置高度
    if (ismax_h) {
      pover.style.height = max_h + "px";
      pover.style.overflowY = "auto";
    }

    config.left = rect.left;
    config.top = rect.top;
  });
}

let inputRange=null
// 过滤文本内容 样式js脚本等
function filterMiddle(bufferText){
  var that=this
  var input=bufferText
    // 1. remove line breaks / Mso classes
  var stringStripper = /(\n|\r| class=(")?Mso[a-zA-Z]+(")?)/g;
  var output = input.replace(stringStripper, ' ');
  // 2. strip Word generated HTML comments
  var commentSripper = new RegExp('<!--(.*?)-->', 'g');
  var output = output.replace(commentSripper, '');
  var tagStripper = new RegExp('<(/)*(meta|link|span|\\?xml:|st1:|o:|font)(.*?)>', 'gi');
  // 3. remove tags leave content if any
  output = output.replace(tagStripper, '');
  // 4. Remove everything in between and including tags '<style(.)style(.)>'
  var badTags = ['style', 'script', 'applet', 'embed', 'noframes', 'noscript'];

  for (var i = 0; i < badTags.length; i++) {
      tagStripper = new RegExp('<' + badTags[i] + '.*?' + badTags[i] + '(.*?)>', 'gi');
      output = output.replace(tagStripper, '');
  }
  // 5. remove attributes ' style="..."'
  var badAttributes = ['style', 'start' , "class"];
  for (var i = 0; i < badAttributes.length; i++) {
      var attributeStripper = new RegExp(' ' + badAttributes[i] + '="(.*?)"', 'gi');
      output = output.replace(attributeStripper, '');
  }
  //中间元素过滤
  $(".textareaWrapper").html(output)
          $(".textareaWrapper").find("*").each(function(el,item){
              // item.removeAttribute("style")
              // item.removeAttribute("class")
              item.removeAttribute("action")
              if(item.nodeName=="IFRAME"||item.nodeName=="STYLE"||item.nodeName=="INPUT"||(item.innerText==""&&item.nodeName!="IMG")||item.nodeName=="BUTTON"){
                $(item).remove()
              }
              // if(item.nodeName=="IMG"&& item.src.search(/^file:\/\//)!=-1){
              //  $(item).remove()
              // }
              // if(item.nodeName=="IMG"&& item.src.indexOf('data:image/')>-1){
              //   $(item).remove()
              //   // that.$message({type:"warning",message:"暂不支持粘贴base64图片"})
              //     // that.convertBase64UrlToBlob(item.src)
              // }
    })
    pasteHTML($(".textareaWrapper").html())
}
function pasteHTML(str){
var selection = window.getSelection ? window.getSelection() : document.selection
  var range
  if (inputRange) {
    range = inputRange
  } else {
    range = selection.createRange ? selection.createRange() : selection.getRangeAt(0)
  }
  if (!window.getSelection) {
    range.pasteHTML(str)
    range.collapse(false)
    range.select()
  } else {
    range.collapse(false)
    var hasR = range.createContextualFragment(str)
    var hasRLlastChild = hasR.lastChild
    while (hasRLlastChild && hasRLlastChild.nodeName.toLowerCase() === 'br' && hasRLlastChild.previousSibling && hasRLlastChild.previousSibling.nodeName.toLowerCase() === 'br') {
      var e = hasRLlastChild
      hasRLlastChild = hasRLlastChild.previousSibling
      hasR.removeChild(e)
    }
    range.insertNode(hasR)
    if (hasRLlastChild) {
      range.setEndAfter(hasRLlastChild)
      range.setStartAfter(hasRLlastChild)
    }
    selection.removeAllRanges()
    selection.addRange(range)
  }
}


//table 内容自适应居中

// 每个组件中利用 mounted update钩子函数中做初始化和更新数据变化调用
//全局中resize监听事件中调用/当侧边导航缩进改变时候调用
 function cusThead (doc) {
  var el = doc.querySelectorAll(".cusTable")[0]
  if(!el){return}
  // var tds = el.tBodies[0].rows[0].cells
  // var ths = el.querySelector("thead").rows[0].cells
  // // 获取每个td宽
  // for (var i = 0; i < tds.length; i++) {
  //     ths[i].style.width = (tds[i].offsetWidth || tds[i].scrollWidth ) + "px"
  // }
  // // 获取tr宽
  // el.querySelector("thead").rows[0].style.width= ( el.tBodies[0].rows[0].offsetWidth|| el.tBodies[0].rows[0].scrollWidth ) + "px"
  //如果页面有2个.cusTable存在   如果多个可循环.cusTable
  for(var n=0;n<doc.querySelectorAll(".cusTable").length;n++){
      var el = doc.querySelectorAll(".cusTable")[n]
      var tds = el.tBodies[0].rows[0].cells
      var ths = el.querySelector("thead").rows[0].cells
      for (var i = 0; i < tds.length; i++) {
          ths[i].style.width = ( tds[i].offsetWidth || tds[i].scrollWidth  ) + "px"
      }
     el.querySelector("thead").rows[0].style.width= (el.tBodies[0].rows[0].offsetWidth || el.tBodies[0].rows[0].scrollWidth) + "px"
  }
}

async function async() {
  let isOk = 0;
  console.time("start");
  do {
    await new Promise(res => {
      setTimeout(() => {
        isOk++;
        res("ok");
      }, 1000);
    });
  } while (isOk < 3);
  console.timeEnd("start");
  console.log("ok");
}

async();

async function async1() {
  let isOk = 0;
  console.time("start1");
  while (isOk < 3) {
    await new Promise(res => {
      setTimeout(() => {
        isOk++;
        res("ok");
      }, 1000);
    });
  }
  console.timeEnd("start1");
  console.log("ok");
}

async1();

async function async2() {
  console.time("start2");
  for (let index = 0; index < 3; index++) {
    let result = await new Promise(res => {
      setTimeout(() => {
        res("ok");
      }, 1000);
    });
  }
  console.timeEnd("start2");
  console.log("ok");
}

async2();
