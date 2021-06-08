/* jshint indent: 2 */

const Sequelize = require('sequelize')
module.exports = function(sequelize, DataTypes) {
    return sequelize.define(
        'member',
        {
            id: {
                autoIncrement: true,
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true
            },
            login_name: {
                type: DataTypes.STRING(50),
                allowNull: true,
                comment: '用户名称'
            },
            login_pwd: {
                type: DataTypes.STRING(50),
                allowNull: true,
                comment: '用户密码'
            },
            real_name: {
                type: DataTypes.STRING(50),
                allowNull: true,
                comment: '用户真实名称'
            },
            gender: {
                type: DataTypes.INTEGER,
                allowNull: false,
                defaultValue: 0
            },
            birthday: {
                type: DataTypes.BIGINT,
                allowNull: true
            },
            mem_photo: {
                type: DataTypes.STRING(300),
                allowNull: true,
                defaultValue:
                    'https://image.yktour.com.cn/g1/M00/06/46/CgAMDFwZ8saAfy0OAABpmwgKF1g142.png'
            },
            zipcode: {
                type: DataTypes.STRING(20),
                allowNull: true
            },
            nation: {
                type: DataTypes.STRING(50),
                allowNull: true,
                comment: '国籍'
            },
            province: {
                type: DataTypes.STRING(15),
                allowNull: true
            },
            city: {
                type: DataTypes.STRING(15),
                allowNull: true
            },
            district: {
                type: DataTypes.STRING(15),
                allowNull: true,
                comment: '地区'
            },
            addresss: {
                type: DataTypes.STRING(200),
                allowNull: true
            },
            company: {
                type: DataTypes.STRING(50),
                allowNull: true
            },
            mobile: {
                type: DataTypes.STRING(15),
                allowNull: true
            },
            mobile_show: {
                type: DataTypes.INTEGER,
                allowNull: true,
                defaultValue: 0
            },
            wechat: {
                type: DataTypes.STRING(50),
                allowNull: true
            },
            wechat_show: {
                type: DataTypes.INTEGER,
                allowNull: true,
                defaultValue: 0
            },
            qq: {
                type: DataTypes.STRING(50),
                allowNull: true
            },
            qq_show: {
                type: DataTypes.INTEGER,
                allowNull: true,
                defaultValue: 0
            },
            id_card: {
                type: DataTypes.STRING(20),
                allowNull: true
            },
            hobby: {
                type: DataTypes.STRING(50),
                allowNull: true
            },
            status: {
                type: DataTypes.INTEGER,
                allowNull: true,
                defaultValue: 0
            },
            last_login_time: {
                type: DataTypes.BIGINT,
                allowNull: true
            },
            openid: {
                type: DataTypes.STRING(50),
                allowNull: true
            },
            session_key: {
                type: DataTypes.STRING(100),
                allowNull: true,
                comment: '登录获取的session_key'
            },
            unionid: {
                type: DataTypes.STRING(100),
                allowNull: true,
                comment: '用户在开放平台的唯一标识符'
            },
            nickName: {
                type: DataTypes.STRING(50),
                allowNull: true,
                comment: '微信昵称'
            }
        },
        {
            sequelize,
            tableName: 'member',
            timestamps: true,
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
