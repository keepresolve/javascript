#  vue-cli 3.*

-  ## [@vue/cli安装](https://cli.vuejs.org/zh/guide/installation.html) 
      
       注意 当前安装后 如果版本没有变 请重新单开命令窗口
     
     - ### [serve安装](https://cli.vuejs.org/zh/guide/prototyping.html)
         -  快速启动 vue-cli-service server

                vue serve //启动根目录下必须存在.vue 或者.js文件
                ./node_modules/.bin/vue-cli-service serve

         -  快速打包 vue-cli-service build

                vue build //根目录下必须存在.vue 或者.js文件
                ./node_modules/.bin/vue-cli-service build

                --modern 使用现代模式构建应用，为现代浏览器交付原生支持的 ES2015 代码，并生成一个兼容老浏览器的包用来自动回退。

                --report 和 --report-json 会根据构建统计生成报告，它会帮助你分析包中包含的模块们的大小。

          - 查看配置
          
                vue inspect //根目录下必须存在.vue 或者.js文件
                ./node_modules/.bin/vue-cli-service inspect

     - ### [create创建](https://cli.vuejs.org/zh/guide/creating-a-project.html#vue-create)

           vue create [packageName]
     - ### [ui界面创建](https://cli.vuejs.org/zh/guide/creating-a-project.html#%E4%BD%BF%E7%94%A8%E5%9B%BE%E5%BD%A2%E5%8C%96%E7%95%8C%E9%9D%A2)

           vue ui

# [vue.config.js](https://cli.vuejs.org/zh/config/#%E5%85%A8%E5%B1%80-cli-%E9%85%8D%E7%BD%AE)

     
## 注意事项

     cache-loader 会默认为 Vue/Babel/TypeScript 编译开启。文件会缓存在 node_modules/.cache 中——如果你遇到了编译方面的问题，记得先删掉缓存目录之后再试试看。

     thread-loader 会在多核 CPU 的机器上为 Babel/TypeScript 转译开启。

     