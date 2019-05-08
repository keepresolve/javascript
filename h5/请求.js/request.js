const fs = require("fs");
const request = require("request");

// 上传
// formData 后台上传文件 createReadStream
// https://github.com/request/request
// multipart/form-data (Multipart Form Uploads)
// const formData = {
//   //普通字段
//   my_field: "my_value",
//   // buffer
//   my_buffer: Buffer.from([1, 2, 3]), //buffer
//   //本地文件
//   my_file: fs.createReadStream(__dirname + "/public/static/index.html"),
//   //多个文件
//   attachments: [
//     fs.createReadStream(__dirname + "/public/static/1.png"),
//     fs.createReadStream(__dirname + "/public/static/2.jpg")
//   ],
//   //  自定义
//   custom_file: {
//     value: fs.createReadStream(__dirname+"/public/static/3.psd"),
//     options: {
//       filename: "2.psd",
//       contentType: "image/psd"
//     }
//   }
// };
// request.post(
//   { url: "http://localhost:4000/file", formData: formData },
//   (err, httpResponse, body) => {
//     if (err) {
//       return console.error("upload failed:", err);
//     }
//     console.log("Upload successful!  Server responded with:", body);
//   }
// );

// 下载
// 响应文件流 输出成文件流
// request('http://google.com/doodle.png').pipe(fs.createWriteStream(__dirname+'/public/download/doodle.png'))
// request
//   .get('http://google.com/doodle.png')
//   .on('response', function(response) {
//     console.log(response.statusCode) // 200
//     console.log(response.headers['content-type']) // 'image/png'
//   })
//   .pipe(request.put('http://mysite.com/doodle.png'))


// var FormData = require('form-data');
// var fs = require('fs');

// var form = new FormData();
// form.append('my_field', 'my value');
// form.append('my_buffer', new Buffer(10));
// form.append('my_file', fs.createReadStream('/foo/bar.jpg'));


// var FormData = require('form-data');
// var http = require('http');

// var form = new FormData();

// http.request('http://nodejs.org/images/logo.png', function(response) {
//   form.append('my_field', 'my value');
//   form.append('my_buffer', new Buffer(10));
//   form.append('my_logo', response);
// });

// var FormData = require('form-data');
// var request = require('request');

// var form = new FormData();

// form.append('my_field', 'my value');
// form.append('my_buffer', new Buffer(10));
// form.append('my_logo', request('http://nodejs.org/images/logo.png'));


