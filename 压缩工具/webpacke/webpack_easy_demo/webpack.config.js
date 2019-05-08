/**
 * (●'◡'●) Created by xxy on 2017/6/27 10:33
 */

module.exports = {
    //定义入口文件
    entry:"./js1.js",
    //定义输出的文件的路径及名称
    output:{
        path:__dirname+"/js",
        filename:"test.js"
    },
    module:{
        //添加依赖的加载器
        loaders:[
            //test:以.css结尾 ;的文件需要什么加载器
            // {test:/\.css$/,loader:"style-loader!css-loader"}
            {test:/\.css$/,loader:["style-loader","css-loader"]}
        ]
    }
}