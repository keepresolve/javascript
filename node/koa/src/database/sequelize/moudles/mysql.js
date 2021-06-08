var DataTypes = require('sequelize').DataTypes
var _access_log = require('./access_log')
var _apps = require('./apps')
var _mediaTable = require('./mediaTable')
var _member = require('./member')
var _user = require('./user')
var _websites = require('./websites')

function initModels(sequelize) {
    var access_log = _access_log(sequelize, DataTypes)
    var apps = _apps(sequelize, DataTypes)
    var mediaTable = _mediaTable(sequelize, DataTypes)
    var member = _member(sequelize, DataTypes)
    var user = _user(sequelize, DataTypes)
    var websites = _websites(sequelize, DataTypes)

    return {
        access_log,
        apps,
        mediaTable,
        member,
        user,
        websites
    }
}
module.exports = initModels
module.exports.initModels = initModels
module.exports.default = initModels
