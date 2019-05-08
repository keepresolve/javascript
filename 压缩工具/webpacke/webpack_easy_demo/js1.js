/**
 * (●'◡'●) Created by xxy on 2017/6/27 9:39
 */

var str = require("./js2");
/* css为样式加载器
 * style为插入到style标签的加载器
  * */
/*
* 从右向左看
* 第一个是要加载的模块
* 第二个是css-loader
* 第三个是style-loader
* */
// require("!style-loader!css-loader!./sty.css")
require("./sty.css");
require("./sty2.css")
document.write(str)