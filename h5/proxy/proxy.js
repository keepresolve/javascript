var express = require('express');
var proxy = require('http-proxy-middleware');
 
var app = express();
app.use(express.static('public'));
app.use('*', proxy({target: 'http://10.0.0.145:5000/', changeOrigin: true}));
app.listen(3000,function(){
    console.log("listen at 3000")
});