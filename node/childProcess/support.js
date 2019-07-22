console.log("进程 " + process.argv[2] + " 执行。" );
let progress=0 
let start = new Date().getSeconds()
let timer= setInterval(v=>{
    progress++
    console.log("进程 " + process.argv[2] + " 执行进度" +progress+"%" +  new Date().getSeconds() );
    if(progress>=100){
        clearInterval(timer)
    }
},100)