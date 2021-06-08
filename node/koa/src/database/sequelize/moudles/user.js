/* jshint indent: 2 */

const Sequelize = require('sequelize')
module.exports = function(sequelize, DataTypes) {
    return sequelize.define(
        'user',
        {
            id: {
                autoIncrement: true,
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true
            },
            username: {
                type: DataTypes.STRING(64),
                allowNull: false,
                unique: 'username'
            },
            email: {
                type: DataTypes.STRING(120),
                allowNull: false,
                unique: 'email'
            },
            password_hash: {
                type: DataTypes.STRING(128),
                allowNull: false
            },
            avatar: {
                type: DataTypes.STRING(128),
                allowNull: false
            }
        },
        {
            sequelize,
            tableName: 'user',
            timestamps: false,
            indexes: [
                {
                    name: 'PRIMARY',
                    unique: true,
                    using: 'BTREE',
                    fields: [{ name: 'id' }]
                },
                {
                    name: 'username',
                    unique: true,
                    using: 'BTREE',
                    fields: [{ name: 'username' }]
                },
                {
                    name: 'email',
                    unique: true,
                    using: 'BTREE',
                    fields: [{ name: 'email' }]
                }
            ]
        }
    )
}
