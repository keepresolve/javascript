const INFO = {
    // 通用错误码
    '200': '方法请求成功',

    '30001': '参数错误',
    '30002': '企业未注册',
    '30003': 'token已过期',
    '30004': '不支持http方法',

    '50000': '服务器错误',
    '50006': '数据库出错'
}

let REDIS_CONFIG = {
    host: process.env.redisHost || 'localhost',
    port: process.env.redisPort || 6379
}
let DB_CONFIG = {
    host: process.env.dbHost || 'localhost',
    port: process.env.dbPort || 3306
}

// let mysql_conf = {
//     dbname: 'emicall_cc_man',
//     uname: 'emicall_cr_s',
//     upwd: 'Emiknit_e23456',
//     host: 'emicall-cr-ext.mysql.rds.aliyuncs.com',
//     port: 3306,
//     dialect: 'mysql',
//     pool: {
//         max: 5,
//         min: 0,
//         idle: 10000
//     }
// }

let mysql_conf = {
    dbname: process.env.mysqlDbname ||  'learn',
    uname: process.env.mysqlUname ||'caoshiyuan',
    upwd: process.env.mysqlUpwd || '123456',
    host: process.env.mysqlHost || '192.144.170.209',
    port: process.env.mysqlPort ||  3306,
    dialect: 'mysql',
    pool: {
        max: 5,
        min: 0,
        idle: 10000
    }
}
// let mysql_conf = {
//     dbname: 'emicall_cc_running',
//     uname: 'root',
//     upwd: 'qwerty',
//     host: '10.0.0.32',
//     port: 3306,
//     dialect: 'mysql',
//     pool: {
//         max: 5,
//         min: 0,
//         idle: 10000
//     }
// }
module.exports = {
    REDIS_CONFIG,
    DB_CONFIG,
    mysql_conf,
    //Enhanced object literals 以前没足够注意
    errorCode(CODE) {
        return INFO[CODE] ? INFO[CODE] : 'system error'
    }
}
