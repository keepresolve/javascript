var express = require('express');
var app = express();
var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({    
  extended: true
}));
// redis 链接
var redis   = require('redis');
var client  = redis.createClient('8383', '127.0.0.1');
//rabbitmq连接
var amqp = require("amqp");
var amqpConn = amqp.createConnection({url: "amqp:guest:guest@127.0.0.1:5672"});
// redis 链接错误
client.on("error", function(error) {
    console.log(error);
});
//mysql
var mysql      = require('mysql');
var mysqlConn = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'test'
});
var orderQueue;
var amqpConnReady = false;
//amqp监听消息进行消费
amqpConn.on('ready', function () {  
    amqpConnReady = true;
    amqpConn.queue('orderQueue', { durable: true, autoDelete: false }, function (queue) {  
        console.log('Queue ' + queue.name + ' is consuming!');  
        orderQueue = queue;
        mysqlConn.connect();
        queue.subscribe(function (message, header, deliveryInfo) {  
            if (message.data) {  
                var messageText = message.data.toString();  
                //console.log(messageText);  
                var data = JSON.parse(messageText); 
                //获得用户地址详细信息
                var  sql = 'SELECT * FROM `address` WHERE `id` = '+ parseInt(data.address) + ' AND `user_id` = ' + data.user_id;
                mysqlConn.query(sql,function (err, result) {
                    if(err){
                      console.log('[SELECT address  ERROR] - ',err.message);
                      return;
                    }
                    if(result) {
                        data.address = JSON.stringify(result[0]);
                        //插入订单
                        var  addSql = 'INSERT INTO `order` (`user_id`,`orderno`,`goods_id`,`address`,`status`,`amount`,`ip`,`express`,`invoice`,`message`,`create_time`,`update_time`) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)';
                        var  addSqlParams = [data.user_id, data.orderno, data.goods_id, data.address, data.status, data.amount, data.ip, data.express, data.invoice, data.message, data.create_time, data.update_time];
                        mysqlConn.query(addSql,addSqlParams,function (err, result) {
                            if(err){
                                console.log('[INSERT Order ERROR] - ',err.message);
                                return;
                            }else{
                                //mysql 商品库存减少
                                var modSql = 'UPDATE `goods` SET `stock` = `stock`-1,`sold` = `sold`+1 WHERE `id` = ?';
                                var modSqlParams = [data.goods_id];
                                mysqlConn.query(modSql,modSqlParams,function (err, result) {
                                   if(err){
                                         console.log('[UPDATE Goods stock ERROR] - ',err.message);
                                         return;
                                   } 
                                   //mysqlConn.end();       
                                });
                                console.log('INSERT Order Ok');
                            }
                            
                        })
                    }
                });
            }  
        });  
    });  
});  
 
//根据token获得用户ID
function getUserId(res, token, callback) {
    if(!token) {
        jsonResponse(res, 500, '身份验证失败');
    }else{
        return client.get(token, function(err, tokenInfo) {
            if(err) {
                 console.log(err);
             }else{
                if(!tokenInfo) {
                    jsonResponse(res, 500, '身份验证失败，请重新登录');
                }else{
                    var user_id = JSON.parse(tokenInfo).id;
                    callback(user_id);
                }
             }
        })
    }
}
 
/**
 * [jsonResponse 接口返回json]
 * @param  {[type]} res    [res]
 * @param  {[type]} status [状态吗]
 * @param  {[type]} message    [信息]
 * @param  {[type]} data   [数据]
 * @return {[type]}        [json]
 */
function jsonResponse(res, code, message, data) {
    return res.json({ code: code, message: message, data: data });
};
 
//生成唯一订单号
function getOrderNo() {
    var date = new Date();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + month + strDate + date.getHours()  + date.getMinutes() + date.getSeconds();
    return currentdate + Math.floor(Math.random()*10000) + '';
}
 
/**
 * [publishOrderMessage 发布下单消息]
 * @param  {[type]} res  [res]
 * @param  {[type]} data [下单信息]
 */
function publishOrderMessage(res, data) {
    if(amqpConnReady) {
        amqpConn.publish('orderQueue', JSON.stringify(data));
    }
 
}
 
/**
 * @getClientIP
 * @desc 获取用户 ip 地址
 * @param {Object} req - 请求
 */
function getClientIP(req) {
    return req.headers['x-forwarded-for'] || // 判断是否有反向代理 IP
        req.connection.remoteAddress || // 判断 connection 的远程 IP
        req.socket.remoteAddress || // 判断后端的 socket 的 IP
        req.connection.socket.remoteAddress;
};
 
//请求下单
app.post('/order', function(req, res) {
    var goods_id = req.body.id;
    var address_id = req.body.address_id;
    var express = req.body.express;
    var invoice = req.body.invoice;
    var message = req.body.message;
    var token = req.get('HTTP_TOKEN');
    if(!address_id) {
        jsonResponse(res, 500, '请选择一个收货地址');
    }else{
    getUserId(res, token, function(user_id) {
        //从redis获取商品信息
        var goods_key = 'goods:' + goods_id;
        client.get(goods_key, function(err, goods) {
             if(err) {
                 console.log(err);
             }else{
                 goods = JSON.parse(goods);
                 if(goods == null) {
                    jsonResponse(res, 404, '404');  
                 }else{
                    var time = Date.parse( new Date()) + '';
                    time = parseInt(time.substr(0, 10));
                    if(goods.end_time < time) {
                        jsonResponse(res, 500, '秒杀已结束');
                    }else if(goods.start_time > time) {
                        jsonResponse(res, 500, '秒杀还未开始');
                    }else{
                        //判断库存
                        var goods_stock_key = 'goods_stock:'+goods_id;
                        client.llen(goods_stock_key, function(err, stock) {
                            if(err) {
                                console.log(err);
                            }else{
                                if(stock <= 0) {
                                    jsonResponse(res, 500, '库存不足');
                                }else{
                                    var orderNo = getOrderNo();
                                    var data = {
                                        user_id: user_id,
                                        orderno: orderNo,
                                        goods_id: goods_id,
                                        address: address_id,
                                        status: 1,
                                        amount: goods.kill_price,
                                        ip: getClientIP(req),
                                        express: express,
                                        invoice: invoice,
                                        message: message,
                                        create_time: time,
                                        update_time: time,
                                    };
                                    //减少库存
                                    client.lpop(goods_stock_key, function(err, ret) {
                                        if(err) {
                                            console.log(err);
                                        }else{
                                            //加入rabbitmq消息队列，发布下单消息
                                            publishOrderMessage(res, data);
                                            var response_data = {
                                                'amount': data.amount,
                                                'orderno': data.orderno
                                            };
                                            jsonResponse(res, 200, 'ok', response_data);
                                        }
                                    })
                                }
                            }
                        })
                    }
                 }   
             }
        })
    })
    }
});
 
var server = app.listen(3000, function() {
    var host = server.address().address;
    var port = server.address().port;
 
    console.log('app listening at http://%s:%s', host, port);
})