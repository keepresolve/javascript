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
