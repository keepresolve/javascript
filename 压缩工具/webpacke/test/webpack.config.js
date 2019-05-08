// const OpenBrowserPlugin=require("open-browser-webpack-plugin")
const webpack = require("webpack");
//配置文件，将一些编译选择放在配置文件中
module.exports = {
    //webpack默认加载
        entry:__dirname + "/app/main.js",//已多次提及的唯一入口文件
        //输出
        output: {
          path: __dirname + "/public",//打包后的文件存放的地方
          filename: "bundle.js"//打包后输出文件的文件名
        },
    module:{
        //loader转换
        loaders:[
            {test:/\.css$/,loader:"style-loader!css-loader"},
            {
                test: /\.json$/,
                // 一个匹配loaders所处理的文件的拓展名的正则表达式（必须）后缀名
                loader: "json-loader"
                   // 包含   // 排除；排斥
                // include/exclude:手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）（可选） 
                // query：为loaders提供额外的设置选项（可选）
              },
                 {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader',//在webpack的module部分的loaders里进行配置即可
                query: {
                  presets: ['es2015','react']
                }
             }
        ]
    },
    //配置webpack-dev-server --是包下面的方法 --open是直接打开 
  devServer: {
    inline: true,//实时刷新
    contentBase:"./public",//本地服务器所加载的页面所在的目录
  // //   port:8080,//设置默认监听端口，如果省略，默认为”8080“
  //   // colors: true,//终端中输出结果为彩色
    historyApiFallback: true//不跳转
  },
    //插件
    //在文件头部输出一些注释信息
    plugins:[
        new webpack.BannerPlugin("webpack 实例"),
        // new OpenBrowserPlugin({url:"http://localhost:8080"})//自动打开

    ]
};