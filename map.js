function parse(res) {
  let data = res.data.linedetails;
  //  data= new Set(data)
  let arr = [];
  for (let item in data) {
    arr.push({
      [item]: data[item]
    });
  }

  console.log(arr);
}

const res = {
  code: 0,
  data: {
    lines: "20路,301路,5路,地铁5号线,机场大巴线,107路,机场快轨",
    lineids: "lzbd,lwes,lxid,lwic,lwdf,ldfx,loin",
    linedetails: {
      lwdf: {
        name: "机场大巴线"
      },
      lwes: {
        name: "301路"
      },
      lwic: {
        name: "地铁5号线"
      },
      ldfx: {
        name: "107路"
      },
      lzbd: {
        name: "20路"
      },
      lxid: {
        name: "5路"
      },
      loin: {
        name: "机场快轨"
      }
    }
  }
};
const result = parse(res);

// data经过parse函数转化后，变成以下结构
/*
    [{
      lxid: {
        name: '5路'
      }
    }, {
      lzbd: {
        name: '20路'
      }
    }, {
      ldfx: {
        name: '107路'
      }
    }, {
      lwes: {
        name: '301路'
      }
    }, {
      lwic: {
        name: '地铁5号线'
      }
    }, {
      loin: {
        name: '机场快轨'
      }
    }, {
      lwdf: {
        name: '机场大巴线'
      }
    }]
    */
