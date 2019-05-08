var childProcess = require('child-process-promise');
// let startProcessCmd='ssh root@47.94.208.57 "cd /home/csy/ && docker-compose -f docker-compose.debug.yml up'
let ip="39.106.40.63";
let dbName="service"
let port="5000"
let programPath="/home/dockerTest/customer_service/"
let processName="test"
let startProcessCmd='ssh pm2@'+ ip + ' "DBNAME=' + dbName + ' PORT=' + port+ ' pm2 start ' + programPath + 'bin/www --name '  + processName + '>/dev/null 2>&1;echo $?"'
childProcess.exec(startProcessCmd)
.then(function (result) {
    var stdout = result.stdout;
    console.log("启动进程返回值", stdout)
    if(Number(stdout) !== 0){
        return  console.log("failed")
    }else{
        return console.log("success")
    }
   
})
.fail(function (err) {
    // console.log(err);
    return Promise.reject({"err":err});
})
// const Docker = require('node-docker-api').Docker

