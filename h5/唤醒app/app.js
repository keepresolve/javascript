!(function(n, e) {
  "object" == typeof exports && "object" == typeof module
    ? (module.exports = e())
    : "function" == typeof define && define.amd
    ? define([], e)
    : "object" == typeof exports
    ? (exports.openApp = e())
    : (n.openApp = e());
})(this, function() {
  return (function(n) {
    function e(o) {
      if (t[o]) return t[o].exports;
      var r = (t[o] = { exports: {}, id: o, loaded: !1 });
      return n[o].call(r.exports, r, r.exports, e), (r.loaded = !0), r.exports;
    }
    var t = {};
    return (
      (e.m = n), (e.c = t), (e.p = "//h5.sinaimg.cn/m/open-app/v1.2.10/"), e(0)
    );
  })([
    function(n, e, t) {
      "use strict";
      function o(n) {
        return n && n.__esModule ? n : { default: n };
      }
      var r = t(11),
        i = o(r),
        u = navigator.userAgent.toLowerCase(),
        c = /aliapp|360 aphone|redmi note|weibo|windvane|ucbrowser|baidubrowser|oppobrowser|miuibrowser|mqqbrowser|huaweiknt-al20|huaweilon|h60-l01|wkbrowser/.test(
          u
        ),
        a = /android|adr/.test(u) && !/windows phone/.test(u),
        f = navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
        s = /;?wv\)+/.test(u),
        l = u.match(/os (\d+)_\d[_\d]* like Mac OS X/i),
        p = l && l.length >= 1 ? l[1] : null,
        d = /chrome|samsung/.test(u),
        m = !s && !c && d && a,
        h = !1,
        v = void 0,
        b = void 0,
        w = {
          scheme: "sinaweibo://gotohome",
          url: "",
          isDownload: !0,
          replaceUrl: !1,
          unilink: "https://weibo.cn/appurl",
          closeUnilink: !1,
          h5pos: null,
          opentime: 1500,
          callback: null,
          log: null
        },
        y = function() {
          var n = Date.now();
          (!v || n - v < w.opentime + 200) &&
            (w.isDownload
              ? w.replaceUrl
                ? window.location.replace(w.url)
                : (window.location = w.url)
              : w.callback && w.callback());
        },
        g = function(n, e) {
          var t = document.getElementById("openIntentLink");
          t ||
            ((t = document.createElement("a")),
            (t.id = "openIntentLink"),
            (t.style.display = "none"),
            document.body.appendChild(t)),
            (t.href = n),
            w.log &&
              w.log.outerHTML &&
              (e
                ? (console.log("Intent鏂瑰紡鍛艰捣, url: " + n),
                  (w.log.innerHTML = "Intent鏂瑰紡鍛艰捣, url: " + n))
                : (console.log("link鏂瑰紡鍛艰捣, url: " + n),
                  (w.log.innerHTML = "link鏂瑰紡鍛艰捣, url: " + n))),
            t.click();
        },
        x = function(n) {
          var e = document.createElement("iframe");
          (e.src = n),
            (e.style.display = "none"),
            w.log &&
              w.log.outerHTML &&
              (console.log("iframe鏂瑰紡鍛艰捣, url: " + n),
              (w.log.innerHTML = "iframe鏂瑰紡鍛艰捣, url: " + n)),
            document.body.appendChild(e);
        },
        k = function(n, e, t) {
          var o = n,
            r = (e || "http://weibo.cn/appurl") + "?scheme=";
          if (!o) return "";
          var i = t ? "h5pos:" + t : "",
            u = /^.+(?:[&?]extparam=)(.*?)(?:&|$)/,
            c = o.match(u);
          return (
            c && c[1] && (i = i ? i + "|" + c[1] : "h5pos:" + c[1]),
            (r += i
              ? encodeURIComponent(o + "&extparam=" + encodeURIComponent(i))
              : encodeURIComponent(o))
          );
        },
        O = function() {
          var n = document.hidden || document.webkitHidden;
          n && b && clearTimeout(b);
        },
        j = function() {
          if (!h) {
            if (
              ((h = !0), (v = Date.now()), !w.closeUnilink && f && p && p >= 9)
            ) {
              var n = k(w.scheme, w.unilink);
              n && (window.location.href = n);
            } else if (m) {
              var e = void 0,
                t = "sinaweibo";
              w.scheme && (t = w.scheme.substring(0, w.scheme.indexOf("://"))),
                (e = w.isDownload
                  ? w.scheme.replace(t, "intent") +
                    "#Intent;scheme=" +
                    t +
                    ";S.browser_fallback_url=" +
                    encodeURIComponent(w.url) +
                    ";end"
                  : w.scheme.replace(t, "intent") +
                    "#Intent;scheme=" +
                    t +
                    ";end"),
                g(e, 1);
            } else
              !s && u.indexOf("safari") > -1 && p && p >= 9
                ? g(w.scheme)
                : x(w.scheme),
                w.url &&
                  ((window.onblur = function() {
                    b && clearTimeout(b);
                  }),
                  (window.onpagehide = function() {
                    b && clearTimeout(b);
                  }),
                  document.addEventListener("visibilitychange", O, !1),
                  document.addEventListener("webkitvisibilitychange", O, !1),
                  (b = setTimeout(function() {
                    document.hidden || document.webkitHidden || y();
                  }, w.opentime)));
            setTimeout(function() {
              h = !1;
            }, w.opentime + 1e3);
          }
        },
        _ = function(n) {
          n && (0, i.default)(w, n),
            !n.url &&
              w.scheme &&
              (w.url =
                "https://m.weibo.cn/feature/openapp?scheme=" +
                encodeURIComponent(w.scheme)),
            j();
        };
      n.exports = { start: _, getUnilink: k };
    },
    function(n, e) {
      var t = (n.exports = { version: "2.6.5" });
      "number" == typeof __e && (__e = t);
    },
    function(n, e, t) {
      n.exports = !t(3)(function() {
        return (
          7 !=
          Object.defineProperty({}, "a", {
            get: function() {
              return 7;
            }
          }).a
        );
      });
    },
    function(n, e) {
      n.exports = function(n) {
        try {
          return !!n();
        } catch (n) {
          return !0;
        }
      };
    },
    function(n, e) {
      var t = (n.exports =
        "undefined" != typeof window && window.Math == Math
          ? window
          : "undefined" != typeof self && self.Math == Math
          ? self
          : Function("return this")());
      "number" == typeof __g && (__g = t);
    },
    function(n, e) {
      n.exports = function(n) {
        return "object" == typeof n ? null !== n : "function" == typeof n;
      };
    },
    function(n, e) {
      n.exports = function(n) {
        if (void 0 == n) throw TypeError("Can't call method on  " + n);
        return n;
      };
    },
    function(n, e) {
      var t = {}.hasOwnProperty;
      n.exports = function(n, e) {
        return t.call(n, e);
      };
    },
    function(n, e, t) {
      var o = t(16);
      n.exports = Object("z").propertyIsEnumerable(0)
        ? Object
        : function(n) {
            return "String" == o(n) ? n.split("") : Object(n);
          };
    },
    function(n, e) {
      var t = Math.ceil,
        o = Math.floor;
      n.exports = function(n) {
        return isNaN((n = +n)) ? 0 : (n > 0 ? o : t)(n);
      };
    },
    function(n, e, t) {
      var o = t(8),
        r = t(6);
      n.exports = function(n) {
        return o(r(n));
      };
    },
    function(n, e, t) {
      n.exports = { default: t(12), __esModule: !0 };
    },
    function(n, e, t) {
      t(38), (n.exports = t(1).Object.assign);
    },
    function(n, e) {
      n.exports = function(n) {
        if ("function" != typeof n) throw TypeError(n + " is not a function!");
        return n;
      };
    },
    function(n, e, t) {
      var o = t(5);
      n.exports = function(n) {
        if (!o(n)) throw TypeError(n + " is not an object!");
        return n;
      };
    },
    function(n, e, t) {
      var o = t(10),
        r = t(34),
        i = t(33);
      n.exports = function(n) {
        return function(e, t, u) {
          var c,
            a = o(e),
            f = r(a.length),
            s = i(u, f);
          if (n && t != t) {
            for (; f > s; ) if (((c = a[s++]), c != c)) return !0;
          } else
            for (; f > s; s++)
              if ((n || s in a) && a[s] === t) return n || s || 0;
          return !n && -1;
        };
      };
    },
    function(n, e) {
      var t = {}.toString;
      n.exports = function(n) {
        return t.call(n).slice(8, -1);
      };
    },
    function(n, e, t) {
      var o = t(13);
      n.exports = function(n, e, t) {
        if ((o(n), void 0 === e)) return n;
        switch (t) {
          case 1:
            return function(t) {
              return n.call(e, t);
            };
          case 2:
            return function(t, o) {
              return n.call(e, t, o);
            };
          case 3:
            return function(t, o, r) {
              return n.call(e, t, o, r);
            };
        }
        return function() {
          return n.apply(e, arguments);
        };
      };
    },
    function(n, e, t) {
      var o = t(5),
        r = t(4).document,
        i = o(r) && o(r.createElement);
      n.exports = function(n) {
        return i ? r.createElement(n) : {};
      };
    },
    function(n, e) {
      n.exports = "constructor,hasOwnProperty,isPrototypeOf,propertyIsEnumerable,toLocaleString,toString,valueOf".split(
        ","
      );
    },
    function(n, e, t) {
      var o = t(4),
        r = t(1),
        i = t(17),
        u = t(21),
        c = t(7),
        a = "prototype",
        f = function(n, e, t) {
          var s,
            l,
            p,
            d = n & f.F,
            m = n & f.G,
            h = n & f.S,
            v = n & f.P,
            b = n & f.B,
            w = n & f.W,
            y = m ? r : r[e] || (r[e] = {}),
            g = y[a],
            x = m ? o : h ? o[e] : (o[e] || {})[a];
          m && (t = e);
          for (s in t)
            (l = !d && x && void 0 !== x[s]),
              (l && c(y, s)) ||
                ((p = l ? x[s] : t[s]),
                (y[s] =
                  m && "function" != typeof x[s]
                    ? t[s]
                    : b && l
                    ? i(p, o)
                    : w && x[s] == p
                    ? (function(n) {
                        var e = function(e, t, o) {
                          if (this instanceof n) {
                            switch (arguments.length) {
                              case 0:
                                return new n();
                              case 1:
                                return new n(e);
                              case 2:
                                return new n(e, t);
                            }
                            return new n(e, t, o);
                          }
                          return n.apply(this, arguments);
                        };
                        return (e[a] = n[a]), e;
                      })(p)
                    : v && "function" == typeof p
                    ? i(Function.call, p)
                    : p),
                v &&
                  (((y.virtual || (y.virtual = {}))[s] = p),
                  n & f.R && g && !g[s] && u(g, s, p)));
        };
      (f.F = 1),
        (f.G = 2),
        (f.S = 4),
        (f.P = 8),
        (f.B = 16),
        (f.W = 32),
        (f.U = 64),
        (f.R = 128),
        (n.exports = f);
    },
    function(n, e, t) {
      var o = t(25),
        r = t(30);
      n.exports = t(2)
        ? function(n, e, t) {
            return o.f(n, e, r(1, t));
          }
        : function(n, e, t) {
            return (n[e] = t), n;
          };
    },
    function(n, e, t) {
      n.exports =
        !t(2) &&
        !t(3)(function() {
          return (
            7 !=
            Object.defineProperty(t(18)("div"), "a", {
              get: function() {
                return 7;
              }
            }).a
          );
        });
    },
    function(n, e) {
      n.exports = !0;
    },
    function(n, e, t) {
      "use strict";
      var o = t(28),
        r = t(26),
        i = t(29),
        u = t(35),
        c = t(8),
        a = Object.assign;
      n.exports =
        !a ||
        t(3)(function() {
          var n = {},
            e = {},
            t = Symbol(),
            o = "abcdefghijklmnopqrst";
          return (
            (n[t] = 7),
            o.split("").forEach(function(n) {
              e[n] = n;
            }),
            7 != a({}, n)[t] || Object.keys(a({}, e)).join("") != o
          );
        })
          ? function(n, e) {
              for (
                var t = u(n), a = arguments.length, f = 1, s = r.f, l = i.f;
                a > f;

              )
                for (
                  var p,
                    d = c(arguments[f++]),
                    m = s ? o(d).concat(s(d)) : o(d),
                    h = m.length,
                    v = 0;
                  h > v;

                )
                  l.call(d, (p = m[v++])) && (t[p] = d[p]);
              return t;
            }
          : a;
    },
    function(n, e, t) {
      var o = t(14),
        r = t(22),
        i = t(36),
        u = Object.defineProperty;
      e.f = t(2)
        ? Object.defineProperty
        : function(n, e, t) {
            if ((o(n), (e = i(e, !0)), o(t), r))
              try {
                return u(n, e, t);
              } catch (n) {}
            if ("get" in t || "set" in t)
              throw TypeError("Accessors not supported!");
            return "value" in t && (n[e] = t.value), n;
          };
    },
    function(n, e) {
      e.f = Object.getOwnPropertySymbols;
    },
    function(n, e, t) {
      var o = t(7),
        r = t(10),
        i = t(15)(!1),
        u = t(31)("IE_PROTO");
      n.exports = function(n, e) {
        var t,
          c = r(n),
          a = 0,
          f = [];
        for (t in c) t != u && o(c, t) && f.push(t);
        for (; e.length > a; ) o(c, (t = e[a++])) && (~i(f, t) || f.push(t));
        return f;
      };
    },
    function(n, e, t) {
      var o = t(27),
        r = t(19);
      n.exports =
        Object.keys ||
        function(n) {
          return o(n, r);
        };
    },
    function(n, e) {
      e.f = {}.propertyIsEnumerable;
    },
    function(n, e) {
      n.exports = function(n, e) {
        return {
          enumerable: !(1 & n),
          configurable: !(2 & n),
          writable: !(4 & n),
          value: e
        };
      };
    },
    function(n, e, t) {
      var o = t(32)("keys"),
        r = t(37);
      n.exports = function(n) {
        return o[n] || (o[n] = r(n));
      };
    },
    function(n, e, t) {
      var o = t(1),
        r = t(4),
        i = "__core-js_shared__",
        u = r[i] || (r[i] = {});
      (n.exports = function(n, e) {
        return u[n] || (u[n] = void 0 !== e ? e : {});
      })("versions", []).push({
        version: o.version,
        mode: t(23) ? "pure" : "global",
        copyright: "漏 2019 Denis Pushkarev (zloirock.ru)"
      });
    },
    function(n, e, t) {
      var o = t(9),
        r = Math.max,
        i = Math.min;
      n.exports = function(n, e) {
        return (n = o(n)), n < 0 ? r(n + e, 0) : i(n, e);
      };
    },
    function(n, e, t) {
      var o = t(9),
        r = Math.min;
      n.exports = function(n) {
        return n > 0 ? r(o(n), 9007199254740991) : 0;
      };
    },
    function(n, e, t) {
      var o = t(6);
      n.exports = function(n) {
        return Object(o(n));
      };
    },
    function(n, e, t) {
      var o = t(5);
      n.exports = function(n, e) {
        if (!o(n)) return n;
        var t, r;
        if (e && "function" == typeof (t = n.toString) && !o((r = t.call(n))))
          return r;
        if ("function" == typeof (t = n.valueOf) && !o((r = t.call(n))))
          return r;
        if (!e && "function" == typeof (t = n.toString) && !o((r = t.call(n))))
          return r;
        throw TypeError("Can't convert object to primitive value");
      };
    },
    function(n, e) {
      var t = 0,
        o = Math.random();
      n.exports = function(n) {
        return "Symbol(".concat(
          void 0 === n ? "" : n,
          ")_",
          (++t + o).toString(36)
        );
      };
    },
    function(n, e, t) {
      var o = t(20);
      o(o.S + o.F, "Object", { assign: t(24) });
    }
  ]);
});
