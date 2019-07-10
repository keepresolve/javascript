var getDocumentHead = function(doc) {
  if (!doc) doc = document;
  return doc.head || doc.getElementsByTagName("head")[0] || doc.documentElement;
};
exports.loadScript = function(path, callback) {
  var head = getDocumentHead();
  var s = document.createElement("script");

  s.src = path;
  head.appendChild(s);

  s.onload = s.onreadystatechange = function(_, isAbort) {
    if (
      isAbort ||
      !s.readyState ||
      s.readyState == "loaded" ||
      s.readyState == "complete"
    ) {
      s = s.onload = s.onreadystatechange = null;
      if (!isAbort) callback();
    }
  };
};
var reateElement = function(tag, ns) {
  return document.createElementNS
    ? document.createElementNS(ns || XHTML_NS, tag)
    : document.createElement(tag);
};
