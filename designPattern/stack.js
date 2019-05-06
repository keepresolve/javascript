function list() {
  this.listSize = 0;
  this.pos = 0; //当前的游标
  this.dataStore = [];

  this.toString = toString;
  //增删改 可以自定义监听 订阅发布等5
  this.find = find;
  this.append = append;
  this.insert = insert;
  this.remove = remove;
  this.clear = clear;
  //遍历
  this.currPos = currPos; //获取当前的游标
  this.front = front;
  this.end = end;
  this.prev = prev;
  this.next = next;
  this.hasNext = hasNext;
  this.hasPrev = hasPrev;

  this.moveto = moveto;

  this.getElement = getElement;
  this.contains = contains;
  this.length = length;
}

function append(element) {
  this.dataStore[this.listSize++] = element;
  return { element, index: this.listSize };
}
function find(element) {
  for (let index = 0; index < this.dataStore.length; index++) {
    if (this.dataStore[index] == element) return index;
  }
  return -1;
}
function remove(element) {
  let findAt = this.find(element);
  if (findAt > -1) {
    this.dataStore.splice(findAt, 1);
    --this.listSize;
    return true;
  }
  return false;
}
/**
 *
 * @param {*新元素} element
 * @param {*旧元素} after
 */
function insert(element, after) {
  var insertPos = this.find(after);
  if (insertPos > -1) {
    this.dataStore.splice(insertPos + 1, 0, element);
    ++this.listSize;
    return true;
  }
  return false;
}
function clear() {
  delete this.dataStore;
  this.dataStore = [];
  this.listSize = this.pos = 0;
}
function contains(element) {
  for (let index = 0; index < this.dataStore.length; index++) {
    if (this.dataStore[index] == element) return true;
  }
  return false;
}

function moveto(position) {
  this.pos = position;
}
function getElement(element) {
  return this.dataStore[this.pos];
}
function currPos() {
  return this.pos;
}
function toString() {
  return this.dataStore;
}
function length() {
  return this.listSize;
}
function hasNext() {
  return this.pos < this.listSize;
}
function hasPrev() {
  return this.pos >= 0;
}
function front() {
  this.pos = 0;
}
function end() {
  this.pos = this.listSize - 1;
}
function prev() {
  --this.pos;
}
function next() {
  if (this.pos < this.listSize) {
    ++this.pos;
  }
}

let names = new list();
names.append("first");
names.append("second");
names.append("third");

console.log(names.toString());

// 迭代器
for (names.front(); names.hasNext(); names.next()) {
  console.log({ element: names.getElement(), index: names.currPos() });
}

//链表
/**
 * 然后就是LinkedList类的方法。在实现这些方法之前，先来看看它们的职责。
 append(element)：向列表尾部添加一个新的项。
 insert(position, element)：向列表的特定位置插入一个新的项。
 remove(element)：从列表中移除一项。
 indexOf(element)：返回元素在列表中的索引。如果列表中没有该元素则返回-1。
 removeAt(position)：从列表的特定位置移除一项。
 isEmpty()：如果链表中不包含任何元素，返回true，如果链表长度大于0则返回false。
 size()：返回链表包含的元素个数。与数组的length属性类似。
 toString()：由于列表项使用了Node类，就需要重写继承自JavaScript对象默认的
toString方法，让其只输出元素的值。
 */
function LinkedList() {
  var Node = function(element) {
    // {1}
    this.element = element;
    this.next = null;
  };
  var length = 0; // {2}
  var head = null; // {3}
  this.append = this.append = function(element) {
    var node = new Node(element), //{1}
      current; //{2}
    if (head === null) {
      //列表中第一个节点 //{3}
      head = node;
    } else {
      current = head; //{4}
      //循环列表，直到找到最后一项
      while (current.next) {
        current = current.next;
      }
      //找到最后一项，将其next赋为node，建立链接
      current.next = node; //{5}
    }
    length++; //更新列表的长度 //{6}
  };
  this.insert = function(position, element) {
    //检查越界值
    if (position >= 0 && position <= length) {
      // var node = new Node(element),
      (current = head), previous, (index = 0);
      if (position === 0) {
        //在第一个位置添加
        node.next = current; //{2}
        head = node;
      } else {
        while (index++ < position) {
          //{3}
          previous = current;
          current = current.next;
        }
        node.next = current; //{4}
        previous.next = node; //{5}
      }
      length++; //更新列表的长度
      return true;
    } else {
      return false; //{6}
    }
  };
  this.removeAt = function(position) {
    //检查越界值
    if (position > -1 && position < length) {
      // {1}
      var current = head, // {2}
        previous, // {3}
        index = 0; // {4}
      //移除第一项
      if (position === 0) {
        // {5}
        head = current.next;
      } else {
        while (index++ < position) {
          // {6}
          previous = current; // {7}
          current = current.next; // {8}
        }
        //将previous与current的下一项链接起来：跳过current，从而移除它
        previous.next = current.next; // {9}
      }
      length--; // {10}
      return current.element;
    } else {
      return null; // {11}
    }
  };
  this.remove = function(element) {
    var index = this.indexOf(element);
    return this.removeAt(index);
  };
  this.indexOf = function(element) {
    var current = head, //{1}
      index = -1;
    while (current) {
      //{2}
      if (element === current.element) {
        return index; //{3}
      }
      index++; //{4}
      current = current.next; //{5}
    }
    return -1;
  };
  this.isEmpty = function() {
    return length === 0;
  };
  this.size = function() {
    return length;
  };
  this.getHead = function() {
    return head;
  };
  this.size = function() {};
  this.toString = function() {
    var current = head, //{1}
      string = ""; //{2}
    while (current) {
      //{3}
      string = current.element; //{4}
      current = current.next; //{5}
    }
    return string; //{6}
  };
  this.print = function() {};
}
