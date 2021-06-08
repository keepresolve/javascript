let mysql = require('./mysql/index')
let sqlite = require('./sequelize/sqlite')
let seqMysql = require('./sequelize/mysql')
const db = {
    mysql,
    sqlite,
    seqMysql
}
module.exports = {
    db
}
