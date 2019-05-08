const path = require('path');//node内置解析路径包
const HtmlWebpackPlugin = require('html-webpack-plugin'); // 通过 npm 安装
const webpack = require('webpack'); // 用于访问内置插件
module.exports = {

// 入口起点 
    // webpack 应该使用哪个模块，webpack 会找出有哪些模块和库是入口起点（直接和间接）依赖的。
    // 就是只要这个文件用到的外部文件依赖统一都加载过来最终打包
    entry: './path/to/my/entry/file.js',
    // 入口配置参考https://doc.webpack-china.org/concepts/entry-points/
 

//打包输出
    output: {  
        // 输出的文件路径
        // path.resolve解析陈绝对路径
        path: path.resolve(__dirname, 'dist'),
        // 最终输出的文件名字
        filename: 'my-first-webpack.bundle.js'

        // 输出配置参考:https://doc.webpack-china.org/configuration/output
      },



//loader加载处理非js文件
    //  1:test(正则匹配) 属性 识别出应该被对应的 loader 进行转换的那些文件
    //  2:use 属性 转换这些文件，从而使其能够被添加到依赖图中最终打包
    //碰到的三种写法凡是loader都需要npm install 手动下载
    module: {
        rules: [
            { test: /\.txt$/, use: 'raw-loader' },
            { 
              test: /\.js$/,//检测所有的js文件
              exclude: [/node_modules/],//省略
              use: [{
                    loader: 'babel-loader',//转码工具
                    options: { presets: ['es2015'] },//转成es5
              }],
            },
            {
                test: /\.css$/,
                use: [
                        { loader: 'style-loader' },
                        {
                            loader: 'css-loader',
                            options: {modules: true}
                        }
                    ]
            }         
        ]
    },
        // 更多详情配置 https://doc.webpack-china.org/concepts/loaders
        // 更多loader https://doc.webpack-china.org/loaders
        // Loader编写https://doc.webpack-china.org/contribute/writing-a-loader
        // 内联配置方法 import Styles from 'style-loader!css-loader?modules!./styles.css';
        // 命令行      webpack --module-bind jade-loader --module-bind 'css=style-loader!css-loader'
          

//插件(plugins)
     // 想要使用一个插件，你只需要 require() 它，然后把它添加到 plugins 数组中
    //  多数插件可以通过选项(option)自定义。
    //  你也可以在一个配置文件中因为不同目的而多次使用同一个插件，这时需要通过使用 new 操作符来创建它的一个实例。
    plugins: [
        new webpack.optimize.UglifyJsPlugin(),
        new HtmlWebpackPlugin({template: './src/index.html'})
      ]
      //内部实现
    //   function ConsoleLogOnBuildWebpackPlugin() {
        //  比如说这是一个插件 new实例化指针
    //     };
    // apply this指向webpack的compiler
    //     ConsoleLogOnBuildWebpackPlugin.prototype.apply = function(compiler) {
    //       compiler.plugin('run', function(compiler, callback) {
    //         console.log("webpack 构建过程开始！！！");
        
    //         callback();
    //       });
    //     };
    //  更多插件配置参考https://doc.webpack-china.org/plugins
  };