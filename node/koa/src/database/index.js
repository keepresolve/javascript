let mysql = require('./mysql/index')
let sqlite = require('./sequelize/sqlite')
let seqMysql = require('./sequelize/sqlite')
const db = {
    mysql,
    sqlite,
    seqMysql
}
module.exports = {
    db
}
