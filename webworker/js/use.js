var startCust = document.querySelector("#startCust");
var start = document.querySelector("#start");
var terminate = document.querySelector("#terminate");
var num = document.querySelector("#num");
var delay = document.querySelector("#delay");
var range = document.querySelector("#range");
let keys = ["id", "createdTime", "name"];

var workers = new Workers("./js/worker.js", {
  //增加删除worker
  change: function(list, worker, type) {
    console.log("主进程change回调", arguments);
    renderSelect(list, worker, type);
    keys = Object.keys(worker);
    renderTable(list);
  },
  /**
   * @params this workers 实例
   * @params event
   * @params worker 当前worker线程
   * @params list  线程池
   * **/
  message(event, worker, list) {
    console.log("主进程message回调", { arg: arguments, that: this });
    let data = event.data;
    let { type } = data;
    // let worker = this.find(id)
    if (!worker) throw `The worker's id is not defined`;
    switch (type) {
      case "seconds":
        renderTable(list);
        break;
    }
  }
});
delay.onchange = debouce(function(event) {
  range.textContent = this.value;
});
startCust.onclick = function() {
  let name = document.querySelector("#custName");
  let url = document.querySelector("#url");
  let worker = workers.create({
    name: name.value || "自定义" + Date.now(),
    url: url.value || "./js/worker2.js",
    delay: delay.value * 1000
  });
};
//start 启动一个worker
start.onclick = function() {
  let worker = workers.create({
    delay: delay.value * 1000
  });
};
//关闭当前worker
terminate.onclick = function() {
  let el = selectiton.selectedOptions[0];
  let worker = workers.terminate(el.value);
};

function debouce(fn) {
  let timeout = null;
  return function() {
    if (timeout) return;
    timeout = setTimeout(() => {
      fn.call(this, ...arguments);
      timeout = null;
    }, 500);
  };
}
function renderSelect(list, worker, type) {
  var selectiton = document.querySelector("#selectiton");
  num.textContent = list.length;
  selectiton.innerHTML = "";
  for (let index = 0; index < list.length; index++) {
    const worker = list[index];
    let option = document.createElement("option");
    option.value = worker.id;
    option.textContent = worker.name;
    selectiton.append(option);
  }
}

function renderTable(list, worker) {
  let otable = document.querySelector("#workersList");
  otable && document.body.removeChild(otable);

  let table = document.createElement("table");
  let thead = document.createElement("thead");
  let tbody = document.createElement("tbody");
  let attr = {
    style: {
      width: "100%"
    },
    border: 1,
    id: "workersList"
  };
  for (const key in attr) {
    if (key == "style") {
      Object.assign(table[key], attr[key]);
    } else {
      table[key] = attr[key];
    }
  }
  keys.map(v => {
    let th = document.createElement("th");
    th.textContent = v;
    thead.appendChild(th);
  });

  list.map(v => {
    let tr = document.createElement("tr");
    keys.map(key => {
      let td = document.createElement("td");
      td.style.textAlign = "center";
      td.textContent = v[key];
      tr.appendChild(td);
    });
    tbody.appendChild(tr);
  });
  table.appendChild(thead);
  table.appendChild(tbody);
  document.body.appendChild(table);
}
