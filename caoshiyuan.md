##### 预测式外呼 
任务 - 批次（重呼/普通） - 客户详情 
一个任务可以有多次批次， (客户详情)。

任务：添加配置好坐席参数等成任务 

批次：`普通批次` 创建任务成功后导入客户生成 。 `重呼批次`当前存在完成批次 通过重呼筛选批次和客户生成的批次。

###### 代码目录(src/veiw/batchCall) 


    TaskList.vue       任务列表详情页面
    AddCallTask.vue     添加编辑任务
    TaskListDetail.vue  任务详情 ：批次列表，批次详情（客户详情）
    CallSeatCount/callResultCount/CallCustomerCount.vue  三个统计页面
    components/     组件目录

##### ivr流程

总机号码管理配置 ivr ，当外线呼入总机号进入ivr配置ivr流程。

ivr流程以节点方式配置创建，默认存在一个入口节点

草稿：针对用户，每个用户修改后都会生成一个草稿状态针对，最终编译成后同步所有当前的ivr流程

###### 节点

- 基本信息 
  
  -  节点名称 类型 
- 节点参数
  
  - 当前节点的一些配置参数
- 节点流转
  
  - 当前节点触发的一些场景事件并流转其他节点
  
###### 节点类型

1. 入口节点（默认节点作为所有节点入口）

2. 播放语音文件（配置上传语音可自动播报）

3. 按键接收（外线呼入设备的按键接收操作，例如：10086流程）

4. 转技能组 

5. 转坐席

6. 转ivr流程（其他ivr）

7. 流程结束


###### 代码目录(src/veiw/ivrConfigure)

    ivr1.vue           列表详情页面   
    ivrProcess.vue     ivr流程（增 改 详情 xml编辑）    
                -      ivrDetail.vue  详情页面
                -      CodeIvrProcess.vue xml编辑页面
                -      errorTitle.vue (实时参数验证)
                -      createNode.vue (创建节点)

###### ivrProcess.vue 

增删改：nodeDetil所有节点类型编辑操作对象，储存所有节点类型通过key匹配

校验：可配置sessionStorage.ivrValidator 实时打开校验  genertortList方法监听节点列表nodeList对象进行校验

xml：xml修改保存和可视化列表同步，前端同步验证时通过返回列表验证 并非xml 

    //所有节点操作对象
    nodeDetil：{
      type_${number}{
       	parameters：节点参数
        events：节点流转事件
        digit:单键事件
        assignment_val：赋值变量 //暂时未开发
      }
    }




 

​           



 



​     

