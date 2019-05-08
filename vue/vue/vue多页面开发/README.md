# vue多页面实例

1:  生成模板

       npm init webpack 

2： \build\webpack.base.conf.js >    module.exports > entry 加入多个页面


        module.exports = {
            context: path.resolve(__dirname, '../'),
            entry: {
                app: './src/main.js',
                one: './src/js/one.js',
                two: './src/js/two.js'
        },

3: \build\webpack.dev.conf.js文件，在module.exports那里找到plugins，
        
        new HtmlWebpackPlugin({  //一个HtmlWebpackPlugin实例生成一个页面
            filename: 'index.html',
            template: 'index.html',
            inject: true,
            chunks: ['app'] //该页面引入的脚本
            }),
            new HtmlWebpackPlugin({
            filename: 'one.html',
            template: 'one.html',
            inject: true,
            chunks: ['one']
            }),
            new HtmlWebpackPlugin({
            filename: 'two.html',
            template: 'two.html',
            inject: true,
            chunks: ['two']
        }),
        在chunks那里的app指的是webpack.base.conf.js的entry那里与之对应的变量名。chunks的作用是每次编译、运行时每一个入口都会对应一个entry，如果没写则引入所有页面的资源。

4 ： 生产环境的 打开/build/webpack.prod/conf.js文件，在plugins那里找到HTMLWebpackPlugin，然后添加如下代码： 
        

        new HtmlWebpackPlugin({
            filename: process.env.NODE_ENV === 'testing'
                ? 'index.html'
                : config.build.index,
            template: 'index.html',
            inject: true,
            minify: {
                removeComments: true,
                collapseWhitespace: true,
                removeAttributeQuotes: true
                // more options:
                // https://github.com/kangax/html-minifier#options-quick-reference
            },
            // necessary to consistently work with multiple chunks via CommonsChunkPlugin
            chunksSortMode: 'dependency',
            chunks: ['manifest', 'vendor', 'app']
        }),
         new HtmlWebpackPlugin({
            filename: config.build.one,
            template: 'one.html',
            inject: true,
            minify: {
                removeComments: true,
                collapseWhitespace: true,
                removeAttributeQuotes: true
            },
            chunksSortMode: 'dependency',
            chunks: ['manifest', 'vendor', 'one']
        }),
        new HtmlWebpackPlugin({
                filename: config.build.two,
                template: 'two.html',
                inject: true,
                minify: {
                    removeComments: true,
                    collapseWhitespace: true,
                    removeAttributeQuotes: true
                },
                chunksSortMode: 'dependency',
                chunks: ['manifest', 'vendor', 'two']
        }),

        其中filename引用的是\config\index.js里的build，每个页面都要配置一个chunks，不然会加载所有页面的资源

5:     之后就对run build也就是编译环境进行配置。首先打开\config\index.js文件，在build里加入这个
        
        index: path.resolve(__dirname, '../dist/index.html'),
        one: path.resolve(__dirname, '../dist/one.html'),
        two: path.resolve(__dirname, '../dist/two.html'),

6:    然后one.js文件可以这样写：
       
        import Vue from 'vue'
        import one from './one.vue'

        Vue.config.productionTip = false

        /* eslint-disable no-new */
        new Vue({
        el: '#one',
        render: h => h(one)
        })
       
       one.vue
        
       <template>
        <div id="one">
            {{msg}}
        </div>
        </template>

        <script>
        export default {
        name: 'one',
        data () {
            return {
            msg: 'I am one'
            }
        }
        }
        </script>

6: two.js  和two.vue 同上  把one改为two 


7： 然后App.vue里通过这样写：
  
        <template>
        <div id="app">
            <a href="one.html">one</a><br>
            <a href="two.html">two</a><br>
            {{msg}}
        </div>
        </template>
8:  忘了一部 根目录下的index.html 在加两个个one/two.html  其中的id就是渲染的id

9: 运行
   
      npm install 
      npm run dev  开发
      npm run build 生产  3个html
