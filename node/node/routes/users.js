var express = require("express");
var genImg = require("./code/index");
var router = express.Router();
console.log({ genImg });
/* GET users listing. */
let codeList = [];
router.get("/authCode", function(req, res, next) {

  let { type, index, code } = req.query;
  index = isNaN(index) ? codeList.length - 1 : index;
  switch (type) {
    case "base64":
      var img = genImg.makeCapcha().img;
      code = genImg.makeCapcha().str;
      let buffer = img.getFileData();
      let base64 = Buffer.from(buffer).toString("base64");
      res.send({
        base64: `data:image/png;base64,${base64}`,
        buffer,
        index: codeList.length
      });
      codeList.push({
        code
      });
      break;
    case "auth":
      let isAuth = code == codeList[index];
      res.send({ code: isAuth ? 200 : 301 });
      break;
    default:
      //image/bmp
      let time =  Object.keys(req.query)[0] || '0'
      var img = genImg.makeCapcha().img;
      code = genImg.makeCapcha().str;
      res.setHeader("Content-Type", "image/bmp");
      codeList.push({
        code,
        time
      });
      console.log({ data: img.getFileData(), img });
      res.end(img.getFileData());
      break;
  }
  console.log({codeList})
});

module.exports = router;
