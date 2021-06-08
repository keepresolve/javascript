/* jshint indent: 2 */

const Sequelize = require('sequelize')
module.exports = function(sequelize, DataTypes) {
    return sequelize.define(
        'websites',
        {
            id: {
                autoIncrement: true,
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true
            },
            name: {
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
            alexa: {
                type: DataTypes.INTEGER,
                allowNull: false,
                defaultValue: 0,
                comment: 'Alexa 排名'
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
            tableName: 'websites',
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
