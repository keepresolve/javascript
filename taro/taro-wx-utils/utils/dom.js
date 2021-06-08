export function _throttle(fn, time = 300) {
  let cd = false;
  return function (...arg) {
    if (cd) return;
    fn.call(this, ...arg);
    cd = true;
    setTimeout(() => {
      cd = false;
    }, time);
  };
}
export function _debounce(callback, delay = 300, immediate) {
  let timer = null;
  return function () {
    let ctx = this;
    timer && clearTimeout(timer);
    if (immediate) {
      !timer && func.apply(context, arguments);
      setTimeout(() => (timer = null), delay);
    } else {
      timer = setTimeout(() => {
        callback.apply(ctx, arguments);
      }, delay);
    }
  };
}
//版本比较
export function compareVersion(v1, v2) {
  v1 = v1.split(".");
  v2 = v2.split(".");
  const len = Math.max(v1.length, v2.length);
  while (v1.length < len) v1.push("0");
  while (v2.length < len) v2.push("0");
  for (let i = 0; i < len; i++) {
    const num1 = parseInt(v1[i]);
    const num2 = parseInt(v2[i]);
    if (num1 > num2) return true;
    else if (num1 < num2) return false;
  }
}
export function sha1(s) {
  var data = new Uint8Array(encodeUTF8(s));
  var i, j, t;
  var l = (((data.length + 8) >>> 6) << 4) + 16,
    s = new Uint8Array(l << 2);
  s.set(new Uint8Array(data.buffer)), (s = new Uint32Array(s.buffer));
  for (t = new DataView(s.buffer), i = 0; i < l; i++)
    s[i] = t.getUint32(i << 2);
  s[data.length >> 2] |= 0x80 << (24 - (data.length & 3) * 8);
  s[l - 1] = data.length << 3;
  var w = [],
    f = [
      function () {
        return (m[1] & m[2]) | (~m[1] & m[3]);
      },
      function () {
        return m[1] ^ m[2] ^ m[3];
      },
      function () {
        return (m[1] & m[2]) | (m[1] & m[3]) | (m[2] & m[3]);
      },
      function () {
        return m[1] ^ m[2] ^ m[3];
      },
    ],
    rol = function (n, c) {
      return (n << c) | (n >>> (32 - c));
    },
    k = [1518500249, 1859775393, -1894007588, -899497514],
    m = [1732584193, -271733879, null, null, -1009589776];
  (m[2] = ~m[0]), (m[3] = ~m[1]);
  for (i = 0; i < s.length; i += 16) {
    var o = m.slice(0);
    for (j = 0; j < 80; j++)
      (w[j] =
        j < 16
          ? s[i + j]
          : rol(w[j - 3] ^ w[j - 8] ^ w[j - 14] ^ w[j - 16], 1)),
        (t =
          (rol(m[0], 5) + f[(j / 20) | 0]() + m[4] + w[j] + k[(j / 20) | 0]) |
          0),
        (m[1] = rol(m[1], 30)),
        m.pop(),
        m.unshift(t);
    for (j = 0; j < 5; j++) m[j] = (m[j] + o[j]) | 0;
  }
  t = new DataView(new Uint32Array(m).buffer);
  for (var i = 0; i < 5; i++) m[i] = t.getUint32(i << 2);

  var hex = Array.prototype.map
    .call(new Uint8Array(new Uint32Array(m).buffer), function (e) {
      return (e < 16 ? "0" : "") + e.toString(16);
    })
    .join("");
  return hex;
}
/**
 *
 * @params {*obejct}  obj  解析对象转参数
 * @param {*string} str      url字符参数转对象
 * @param {*Array} exclude  不包含的对象key
 */
export function stringify(obj, exclude = []) {
  let arr = [];
  for (const key in obj) {
    if (exclude.indexOf(key) == -1 && obj[key]) arr.push(`${key}=${obj[key]}`);
  }
  return arr.join("&");
}
export const getUuid = (function () {
  let count = 0;
  return function (key = "null") {
    count++;
    return `uuid_${count}_${new Date().getTime()}_${key}`;
  };
})();
export const Dom = {
  /**
     *
     * @param {*} elstr   dom 元素选择器
     * @param {} context  当前是组件的话 传入上下文this  
     * @param {object} options {
     *  duration: 300, 
        thresholdTop: 0,   距离上面的偏移量
       
        position         // top(默认)  center  bottom 
     *       } 
     */
  // isCenter: true    //是否滚动到中间的可是区域
  systemInfo: {
    windowHeight: 0,
  },
  srcollIntoView(elstr, context, options = {}) {
    const $options = Object.assign(
      {
        duration: 300,
        thresholdTop: 0,
        // isCenter: true,
        position: "top",
      },
      options
    );
    const { position, thresholdTop, duration } = $options;
    const query = context
      ? wx.createSelectorQuery().in(context)
      : wx.createSelectorQuery();
    query.selectViewport().scrollOffset();
    query.select(elstr).boundingClientRect();
    query.exec((res) => {
      if (!res[0] || !res[1]) return;

      if (this.systemInfo.windowHeight == 0) {
        try {
          this.systemInfo = wx.getSystemInfoSync();
        } catch (error) {}
      }
      const { windowHeight } = this.systemInfo;
      const [viewport, dom] = res;
      const { scrollTop, scrollHeight } = viewport;
      let offset = thresholdTop;

      switch (position) {
        case "center":
          offset += windowHeight / 2;
          break;
        case "bttom":
          offset = thresholdTop;
          break;
        default:
          offset += windowHeight;
          break;
      }
      wx.pageScrollTo({
        scrollTop: scrollTop - offset, //scrollTop + dom.top - (isCenter ? windowHeight / 2 : 0) - thresholdTop;
        duration,
      });
    });
  },
};

//taro-plugin-canvas  海报插件 
export const cavansHepler = {
  getTextWidth(canvasCtx, value = "", fontSize = 24) {
    canvasCtx.restore();
    canvasCtx.setFontSize(fontSize);
    let w = 0;
    w = canvasCtx.measureText(value).width;
    canvasCtx.restore();

    return w;
  },

  getTextLine(canvasCtx, value = "", fontSize = 24, maxWidth, maxLine = 2) {
    if (!value) return 0;
    canvasCtx.restore();
    canvasCtx.setFontSize(fontSize);
    let w = 0;
    let line = 0;
    w = canvasCtx.measureText(value).width;

    canvasCtx.restore();
    line = Math.ceil(w / maxWidth);
    if (maxLine && maxLine < line) line = maxLine;
    return line;
  },
  getTextByMaxWidth(
    canvasCtx,
    value = "",
    fontSize = 24,
    maxWidth,
    expand = false
  ) {
    let Idx = 0;
    canvasCtx.restore();
    canvasCtx.setFontSize(fontSize);
    let txtWidth = 0;

    if (canvasCtx.measureText(value).width <= maxWidth) {
      canvasCtx.restore();
      return value;
    }

    if (expand) txtWidth += canvasCtx.measureText("...").width;
    while (txtWidth <= maxWidth) {
      txtWidth += canvasCtx.measureText(value[Idx]).width;
      Idx++;
    }

    canvasCtx.restore();
    return expand ? value.slice(0, Idx) + "..." : value.slice(0, Idx);
  },
};
