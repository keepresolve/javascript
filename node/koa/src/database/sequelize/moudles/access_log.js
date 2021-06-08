/* jshint indent: 2 */

const Sequelize = require('sequelize')
module.exports = function(sequelize, DataTypes) {
    return sequelize.define(
        'access_log',
        {
            aid: {
                autoIncrement: true,
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true
            },
            site_id: {
                type: DataTypes.INTEGER,
                allowNull: false,
                defaultValue: 0,
                comment: '网站id'
            },
            count: {
                type: DataTypes.INTEGER,
                allowNull: false,
                defaultValue: 0,
                comment: '访问次数'
            },
            date: {
                type: DataTypes.DATEONLY,
                allowNull: false
            }
        },
        {
            sequelize,
            tableName: 'access_log',
            timestamps: false,
            indexes: [
                {
                    name: 'PRIMARY',
                    unique: true,
                    using: 'BTREE',
                    fields: [{ name: 'aid' }]
                }
            ]
        }
    )
}
