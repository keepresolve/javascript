var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});
router.get('/jsonp', function(req, res, next) {
  // req.query()
  
  res.send(req.query.callback+"("+JSON.stringify({data:1231})+")");
});
module.exports = router;
