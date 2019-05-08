var express = require('express');
var genImg= require("./code/index")
var router = express.Router();
console.log({genImg})
/* GET users listing. */
var v_code=""
router.get('/authCode', function(req, res, next) {
  if(req.query.code&&v_code!==""){
     console.log(req.query.code,v_code)
      res.end(v_code==req.query.code)
      return 
}

  var img =genImg.makeCapcha().img;
  v_code=genImg.makeCapcha().str
  res.setHeader('Content-Type', 'image/bmp');
  res.end(img.getFileData());
});


module.exports = router;
