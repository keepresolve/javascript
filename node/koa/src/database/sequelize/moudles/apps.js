/* jshint indent: 2 */

const Sequelize = require('sequelize')
module.exports = function(sequelize, DataTypes) {
    return sequelize.define(
        'apps',
        {
            id: {
                autoIncrement: true,
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true
            },
            app_name: {
                type: DataTypes.CHAR(20),
                allowNull: false,
                defaultValue: '',
                comment: '站点名称'
            },
            url: {
                type: DataTypes.STRING(255),
                allowNull: false,
                defaultValue: ''
            },
            country: {
                type: DataTypes.CHAR(10),
                allowNull: false,
                defaultValue: '',
                comment: '国家'
            }
        },
        {
            sequelize,
            tableName: 'apps',
            timestamps: false,
            indexes: [
                {
                    name: 'PRIMARY',
                    unique: true,
                    using: 'BTREE',
                    fields: [{ name: 'id' }]
                }
            ]
        }
    )
}
