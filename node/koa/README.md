### 项目名称

     emicent_koa2_template

#### 基本功能

     1：  全局使用 async await 处理
     2：  日志       NODE_ENV==production 输出文件形式
     3：  npm hook  启动前可做一些操作
     4：  npm run lint   
           eslint 代码规范集成prettier格式化。
          配合vscode ESLint插件,在终端的问题栏错误提示并高亮显示
          .eslintrc.js 文件中 globals 可配置自定义的全局变量
     5: bin

#### 大致设计

**目录结构**
generator 应用目录
├─bin  
│ └─pack.sh npm 打包脚本
│
├─src 实际逻辑代码目录
│ ├─config 配置目录
│ │ ├─index.js 入口文件
│ │ └─ ...  
│ │
│ ├─controller 逻辑处理
│ │ ├─user 示例
│ │ │ ├─index.js 入口文件
│ │ │ └─ ...  
│ │ │
│ │ └─ ...  
│ │
│ ├─database 数据库
│ ├─node_env 环境变量
│ ├─routes 路由配置
│ │ ├─index.js 入口文件
│ │ ├─user.js 路由示例
│ │ │
│ │ └─ ...  
│ │ │
│ ├─util 工具
│ │ ├─beforelnit.js npm hook 启动前钩子
│ │ ├─init.js 程序初始化
│ │ ├─logger.js 日志配置
│ │ │
│ │ └─ ...  
│ │ │
│ ├─app.js 启动文件
│ │
├─static 静态资源目录
│ └─...  
│
├─package.json  
├─README.md 当前文件

大致处理流程

**初始化**:  
src/util/init.js
1： logger 配置 koa-logger winston 包 输出文件形式
2： app 全局对象挂载对象 db,redis 等操作使用较多的对象实例
3： middleware/router koa-body 包解析 request 中参数 router 注册
4： error 错误监听

**运行**：
通过 npm 的 pre hook 在启动 node 程序前做好初始化工作，比如启动 redis
npm run dev 程序引用 nodemon 热跟新方便开发

**程序要点**：

    1. 基于koa而不是express，更复杂的框架，比如eggjs暂时不考虑，因为koa+router就能满足我们基本需求，我们重点是质检处理，但es6的语法和新特性我们会尽量使用。

**后期重点**：
