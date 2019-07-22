//所有传输到网路层都是buffer

// var fs = require('fs');
// var rs = fs.createReadStream('test.md', {highWaterMark: 11});    //highWaterMark 限制每次读取的长度11 中文有乱码 不限制没事
// //data事件中获取的chunk对象其实就是buffer对象。这里需要注意的是data += chunk;这句话，也就拼接buffer。其实质是data = data.toString() + chunk.toString();。这里其实对于中文的支持就会存在问题。因为，英语环境下，不需要转码，直接拼接转换就行。对于宽字符的中文，就很有问题了，例如李白的静夜思进行读取和转换：
// rs.setEncoding('utf8');//可解决乱码  通过这个方法，我们传递的不再是buffer对象，而是编码后的字符串了，这样做之后就可以得到正确的输出了：
// var data = '';
// rs.on("data", function (chunk){
//     console.log({chunk})
// data += chunk;
// });
// rs.on("end", function () {
// console.log(data);
// });



var http = require('http');
var helloworld = "";
for (var i = 0; i < 1024 * 10; i++) {
    helloworld += "a";
}
// helloworld = new Buffer(helloworld);  //da

http.createServer(function (req, res) {
    res.writeHead(200);
    res.end(helloworld);
}).listen(8001);