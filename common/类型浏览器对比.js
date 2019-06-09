export function isString(obj) {
  return Object.prototype.toString.call(obj) === "[object String]";
}

export function isObject(obj) {
  return Object.prototype.toString.call(obj) === "[object Object]";
}

export function isHtmlElement(node) {
  return node && node.nodeType === Node.ELEMENT_NODE;
}

export const isFunction = functionToCheck => {
  var getType = {};
  return (
    functionToCheck &&
    getType.toString.call(functionToCheck) === "[object Function]"
  );
};

export const isUndefined = val => {
  return val === void 0;
};

export const isDefined = val => {
  return val !== undefined && val !== null;
};

//浏览器
export const isIE = function() {
  return !Vue.prototype.$isServer && !isNaN(Number(document.documentMode));
};

export const isEdge = function() {
  return !Vue.prototype.$isServer && navigator.userAgent.indexOf("Edge") > -1;
};


//对比
export const looseEqual = function(a, b) {
  const isObjectA = isObject(a);
  const isObjectB = isObject(b);
  if (isObjectA && isObjectB) {
    return JSON.stringify(a) === JSON.stringify(b);
  } else if (!isObjectA && !isObjectB) {
    return String(a) === String(b);
  } else {
    return false;
  }
};
// 数组对比
export const arrayEquals = function(arrayA, arrayB) {
  arrayA = arrayA || [];
  arrayB = arrayB || [];

  if (arrayA.length !== arrayB.length) {
    return false;
  }

  for (let i = 0; i < arrayA.length; i++) {
    if (!looseEqual(arrayA[i], arrayB[i])) {
      return false;
    }
  }

  return true;
};
// 对比数组对象字符串
export const isEqual = function(value1, value2) {
  if (Array.isArray(value1) && Array.isArray(value2)) {
    return arrayEquals(value1, value2);
  }
  return looseEqual(value1, value2);
};

// 是否为空
export const isEmpty = function(val) {
  // null or undefined
  if (val == null) return true;

  if (typeof val === 'boolean') return false;

  if (typeof val === 'number') return !val;

  if (val instanceof Error) return val.message === '';

  switch (Object.prototype.toString.call(val)) {
    // String or Array
    case '[object String]':
    case '[object Array]':
      return !val.length;

    // Map or Set or File
    case '[object File]':
    case '[object Map]':
    case '[object Set]': {
      return !val.size;
    }
    // Plain Object
    case '[object Object]': {
      return !Object.keys(val).length;
    }
  }

  return false;
};
