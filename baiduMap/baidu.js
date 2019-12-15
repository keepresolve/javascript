(function () {
    window.BMap_loadScriptTime = (new Date).getTime();
    window.BMap = window.BMap || {};
    window.BMap.apiLoad = function () {
        delete window.BMap.apiLoad;
        if (typeof initialize == "function") { initialize() }
    };
    var s = document.createElement('script');
    s.src = 'http://api.map.baidu.com/getscript?v=2.0&ak=eW8TqsR3V62vFBewTSKIczwwePpDXf9T&services=&t=20191112103629';
    document.body.appendChild(s);
})();