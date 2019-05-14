#  

   1： 请求到响应渲染页面  一定保证唯一性 id等
         
         function getDetail(id){
             axios.get("detail",{id:id}).then(()=>{
                    
             })
         }
        應該拿到2的數據 但是這樣則是拿到1的
        getDetail(1)  后返回
        getDetail(2)  先返回
        
        var currentId=0
        function getDetail(id){
            currentId=id
             axios.get("detail",{id:id}).then(()=>{
                     if(currentId==id)
             })
         }