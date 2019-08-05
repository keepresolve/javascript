const { mysql_conf } = require('../../config/index')
//https://www.npmjs.com/package/mysql#establishing-connections
var mysql = require('mysql')
// var connection = mysql.createConnection({
//     host: mysql_conf.host,
//     user: mysql_conf.uname,
//     password: mysql_conf.upwd,
//     database: mysql_conf.dbname,
//     port: 3306
// })

// connection.query('select * from cc_talk_api_push_data', function(
//     err,
//     rows,
//     fields
// ) {
//     if (err) throw err
//     console.log(rows)
//     connection.end()
// })

var connnectionPool = mysql.createPool({
    host: mysql_conf.host,
    user: mysql_conf.uname,
    password: mysql_conf.upwd,
    database: mysql_conf.dbname
})

module.exports = {
    connection(cb) {
        return new Promise(res => {
            connnectionPool.getConnection(function(err, db) {
                if (err) {
                    res(null)
                    cb && cb(null)
                } else {
                    res(db)
                    cb && cb(db)
                }
            })
        })
    },
    query(querySql, cb) {
        return new Promise(res => {
            if (typeof querySql != 'string') {
                cb &&
                    cb({
                        code: 301,
                        info: '语句错误'
                    })
                res({
                    code: 301,
                    info: '语句错误'
                })
            }
            connnectionPool.getConnection(function(err, db) {
                if (err) {
                    console.error('CONNECTION error: ', err)
                    res({
                        code: 500,
                        err: err,
                        info: '链接失败'
                    })
                    cb &&
                        cb({
                            code: 500,
                            err: err,
                            info: '链接失败'
                        })
                } else {
                    db.query(querySql, function(err, rows, fields) {
                        if (err) {
                            console.log('Query data ERROR!')
                            res({
                                code: 301,
                                err: err,
                                info: 'sql语句执行失败'
                            })
                            cb &&
                                cb({
                                    code: 301,
                                    err: err,
                                    info: 'sql语句执行失败'
                                })
                        }
                        res({
                            code: 200,
                            info: '执行成功',
                            data: { rows, fields }
                        })
                        cb &&
                            cb({
                                code: 200,
                                info: '执行成功',
                                data: { rows, fields }
                            })

                        db.release()
                    })
                }
            })
        })
    }
}
