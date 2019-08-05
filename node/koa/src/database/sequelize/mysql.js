const { mysql_conf } = require('../../config/index')
const Sequelize = require('sequelize')

// const sequelize = new Sequelize(
//     'emicall_cc_running',
//     'emicall_cr_s',
//     'Emiknit_e23456',
//     {
//         host: 'emicall-cr.mysql.rds.aliyuncs.com',
//         dialect: 'mysql'
//     }
// )

// const sequelize = new Sequelize(
//     'mysql://emicall_cr_s:Emiknit_e23456@emicall-cr.mysql.rds.aliyuncs.com:3306/emicall_cc_running'
// )
var sequelize = new Sequelize(
    mysql_conf.dbname,
    mysql_conf.uname,
    mysql_conf.upwd,
    {
        host: mysql_conf.host,
        dialect: mysql_conf.dialect,
        pool: mysql_conf.pool
    }
)
sequelize
    .authenticate()
    .then(() => {
        console.log('Connection has been established successfully.')
    })
    .catch(err => {
        console.error('Unable to connect to the database:', err)
    })
