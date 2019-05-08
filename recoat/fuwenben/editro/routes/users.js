var express = require('express');
var co = require('co');
var axios = require('axios');
var jwt = require('jsonwebtoken');//https://www.jianshu.com/p/a7882080c541
var router = express.Router();

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send('respond with a resource');
});
router.post('/login', function (req, res, next) {
  robotLogin(req, res)
});
module.exports = router;
function robotLogin(req, res) {
    var reqParam = req.body;
    var secret = 'sinicnet';// faqRobot.secretKey
    //jwt生成加密参数
    var jwtStr = jwt.sign({
      name: reqParam.userName, //用户名称
      email: reqParam.email //用户邮箱
    }, secret, {
        // expiresIn: Date.now() / 1000 + 2 * 60 * 60 //秒到期时间 ，两小时有效性校验，不传不校验
      });
    console.log(jwtStr);
    res.json({ code: 200, info: '获取成功', data: { jwtStr: jwtStr, invokeKey: 'emicnet' } })
    // res.json("sadsad")
    res.end()
}
