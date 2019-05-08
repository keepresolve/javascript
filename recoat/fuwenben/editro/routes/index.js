var express = require('express');
var co = require('co');
var axios = require('axios');
var jwt = require('jsonwebtoken');//https://www.jianshu.com/p/a7882080c541
var router = express.Router();
/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;

