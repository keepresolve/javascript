var OpenBrowserPlugin=require("open-browser-webpack-plugin")
var webpack=require("webpack")
module.exports = {
   devtool: 'source-map',//配置生成Source Maps，选择合适的选项 webpack -p 压缩

  //进入
  entry:__dirname + "/app/main.js",//已多次提及的唯一入口文件
  //输出
  output: {
    path: __dirname + "/public",//打包后的文件存放的地方
    filename: "bundle.js"//打包后输出文件的文件名
  },
  // __dirname是node.js中的一个全局变量，它指向当前执行脚本所在的目录。

  // loader josn
  module: {//在配置文件里添加JSON loader
    loaders: [
      {
        test: /\.json$/,
        // 一个匹配loaders所处理的文件的拓展名的正则表达式（必须）后缀名
        loader: "json-loader"
           // 包含   // 排除；排斥
        // include/exclude:手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）（可选） 
        // query：为loaders提供额外的设置选项（可选）
      },
        // css
      {
        test: /\.css$/,
        loader: "style-loader!css-loader"//第一种
        // loaders:[
        //     "style-loader",
        //     "css-loader"
        // ]
      },
      // js es6 react
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',//在webpack的module部分的loaders里进行配置即可
        query: {
          presets: ['es2015','react']
        }
      }
      // less
      // {
      //   test:"/\.less$/",
      //   loader:"style-loader!css-loader!less-loader"

      // }//             
    
    ]
  },
  // webpack-dev-server
  // devServer: {
  //   inline: true//实时刷新
  //   // contentBase:"./public",//本地服务器所加载的页面所在的目录
  //   // port:8080,//设置默认监听端口，如果省略，默认为”8080“
  //   // colors: true,//终端中输出结果为彩色
  //   // historyApiFallback: true,//不跳转
  // }
  plugins:[
   new OpenBrowserPlugin({url:"http://localhost:8080/public/"})
  ]
}
//运行命令的时候自动回执行这个文件