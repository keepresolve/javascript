// https://blog.csdn.net/real_bird/article/details/55510296
// 禁用右键 / 修改右键菜单;
document.oncontextmenu = function(e) {
  awesomeMenu(e);
};

function awesomeMenu(e) {
  var x = e.clientX;
  var y = e.clientY;

  // 获取到鼠标位置后就可以自定义菜单了
}
// 范围随机数

function randomRange(begin, end) {
  return Math.floor(Math.random() * (end - begin)) + begin;
}

// 操作兄弟元素（jq是siblings()）

function siblings(obj, callback) {
  var children = obj.parentElement.children;
  var arr = [].slice.call(children);
  arr.forEach(function(item, index, arr) {
    if (item != obj && callback) {
      callback.call(item);
    }
  });
}
// js使一个元素居中

function centerElement(id) {
  var boxDom = document.getElementById(id);
  var sw = boxDom.offsetWidth;
  var sh = boxDom.offsetHeight;
  var dw = window.innerWidth;
  var dh = window.innerHeight;

  var cleft = (dw - sw) / 2;
  var ctop = (dh - sh) / 2;

  boxDom.style.left = cleft + "px";
  boxDom.style.top = ctop + "px";
}
// 获取滚动条宽度;

function getScrollbarWidth() {
  var oP = document.createElement("p"),
    styles = {
      width: "100px",
      height: "100px",
      overflowY: "scroll"
    },
    i,
    scrollbarWidth;
  for (i in styles) {
    oP.style[i] = styles[i];
  }
  document.body.appendChild(oP);
  scrollbarWidth = oP.offsetWidth - oP.clientWidth;
  oP.parentElement.removeChild(oP);

  return scrollbarWidth;
}

// 获取鼠标位置

function getMounsePosition(e) {
  var event = getEvent(e);
  var x = 0,
    y = 0;

  if (event.pageX && event.pageY) {
    x = event.pageX;
    y = event.pageY;
  } else {
    x =
      event.cientX + document.documentElement.scrollLeft ||
      document.body.scrollLeft;
    y =
      event.cientY + document.documentElement.scrollTop ||
      document.body.scrollTop;
  }

  return { x: x, y: y };
}
// 混入
function mix(target) {
  var args = [].slice.call(arguments);

  for (var i = 1, len = args.length; i < len; i++) {
    while (args[i]) {
      for (var key in args[i]) {
        if (args[i].hasOwnProperty(key)) {
          target[key] = args[i][key];
        }
      }
      i++;
    }
  }

  return target;
}
// 拿到对象的css属性

function getStyle(dom, cssAttr) {
  return window.getComputedStyle
    ? window.getComputedStyle(dom, null)[cssAttr]
    : dom.currentStyle[cssAttr];
}

// move动画，涉及px的属性，包括透明度

function move(dom, json, callback) {
  clearInterval(dom.timer); //每一次move之前都要清除动画。否则一个leave后没清动画，下一个无法onmouseover
  dom.timer = setInterval(function() {
    //每30秒执行一遍所有的attr属性，和if（mark）
    var mark = true; //设置mark--是因为有多个属性。多个属性同时满足条件，才执行if（mark）
    for (var attr in json) {
      var cur = 0;
      if (attr == "opacity") {
        cur = getStyle(dom, attr) * 100; //乘以100是为了方便改变speed
      } else {
        var cur = parseInt(getStyle(dom, attr)) || 0; //如果没设置属性默认让它为0
      }
      var target = json[attr]; //move的目标
      var speed = (target - cur) * 0.5; //速度的绝对值一直在减小
      speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed); //太小了为+-1
      if (target > cur) {
        //从小变到大的时候，还没完成
        mark = false; //直到三个都相等mark才是true
        cur += speed; //cur网target改变
        if (cur >= target) {
          //不小心超过了，就等于target
          cur = target;
        }
      } else if (cur > target) {
        //从大变小 json[attr] < cur
        mark = false;
        cur += speed;
        if (cur <= target) {
          cur = target;
        }
      }
      if (attr == "opacity") {
        //如果属性是透明度
        dom.style[attr] = cur / 100;
      } else {
        dom.style[attr] = cur + "px";
      }
    }
    if (mark) {
      //知道所有的cur == target 时 mark 才为 true
      clearInterval(dom.timer); //完成了当前阶段，清除定时器
      if (callback) {
        //有回调函数，就执行回调函数
        callback.call(dom);
      }
    }
  }, 30);
}
// 设置光标的位置

function setCaretPosition(ctrl, pos) {
  if (ctrl.setSelectionRange) {
    ctrl.focus();
    ctrl.setSelectionRange(pos, pos);
  } else if (ctrl.createTextRange) {
    var range = ctrl.createTextRange();
    range.collapse(true);
    range.moveEnd("character", pos);
    range.moveStart("character", pos);
    range.select();
  }
}

// 在光标的位置插入值;
//
function insertText(obj, text) {
  if (document.selection) {
    var sel = document.selection.createRange(); //返回 TextRange 或 ControlRange 对象
    sel.text = text;
  } else if (
    typeof obj.selectionStart === "number" &&
    typeof obj.selectionEnd === "number"
  ) {
    var startPos = obj.selectionStart; //选中的开始位置
    var endPos = obj.selectionEnd; //选中的结束位置
    var cursorPos = startPos; //光标的开始位置 和选中的开始位置相同
    var tempStr = obj.value; //拿到对象的值  textarea中的值

    obj.value =
      tempStr.substring(0, startPos) +
      text +
      tempStr.substring(endPos, tempStr.length); //把text插入到光标位置
    cursorPos += str.lenth; //更新光标的值
    obj.selectionStart = obj.selectionEnd = cursorPos; //将光标放到正确位置
  } else {
    obj.value += text;
  }
}
// 停止冒泡

function stopPropagation(event) {
  if (event.stopPropagation) {
    event.stopPropagation();
  } else {
    event.cancelBubble = true;
  }
}
// 阻止默认行为;

function preventDefault(event) {
  if (event.preventDefault) {
    event.preventDefault();
  } else {
    event.returnValue = false; //兼容老版本ie
  }
}
// 拿到真正的目标而非冒泡目标

function getTarget(event) {
  return event.target || event.srcElement; //兼容老版本ie
}
// 拿到事件对象

function getEvent(event) {
  return event || window.event;
}

// 移除事件处理程序

function removeHandle(dom, type, handle) {
  if (dom.removeEventListener) {
    dom.removeEventListener(type, handle);
  } else if (dom.detachEvent) {
    dom.detachEvent("on" + type, handle);
  } else {
    dom["on" + type] = null;
  }
}

//Dom0级事件处理程序 动态绑定 btn.onclinck = function(){this === btn};

/*使用attachEvent方法时，
    1...事件处理程序在全局作用域运行，this等于window；
    2...添加多个时，按相反顺序执行
    3...必须加on
*/

function addHandle(dom, type, handle) {
  if (dom.addEventListener) {
    dom.addEventListener(type, handle, false);
  } else if (dom.attachEvent) {
    dom.attachEvent("on" + type, handle);
  } else {
    //DOM0级
    dom["on" + type] = handle;
  }
}

// 拿到总的offsetTop

function getOffsetTop(dom) {
  var actualTop = dom.offsetTop;
  var curr = dom.offsetParent;

  while (curr) {
    actualTop += curr.offsetTop;
    curr = curr.offsetParent;
  }

  return actualTop;
}

// 拿到总的offsetLeft

function getOffsetLeft(dom) {
  var actualLeft = dom.offsetLeft;
  var curr = dom.offsetParent;

  while (curr) {
    actualLeft += curr.offsetLeft;
    curr = curr.offsetParent;
  }

  return actualLeft;
}

// 驼峰转换
function cached(fn) {
  const cache = Object.create(null);
  return function cachedFn(str) {
    const hit = cache[str];
    return hit || (cache[str] = fn(str));
  };
}
const camelizeRE = /-(\w)/g;
const camelize = cached(str => {
  return str.replace(camelizeRE, (_, c) => (c ? c.toUpperCase() : ""));
});
