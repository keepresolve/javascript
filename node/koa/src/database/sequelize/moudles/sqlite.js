module.exports = async (sequelize, Sequelize) => {
    /**
     * 子企业表，用于存储各个企业的一些配置信息
     * */

    const Accout = sequelize.define(
        'Accout',
        {
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                primaryKey: true,
                autoIncrement: true
            }, //自增id
            accoutName: {
                type: Sequelize.TEXT,
                allowNull: false
            }, //企业名称
            password: {
                type: Sequelize.TEXT,
                allowNull: false
            }, //企业域名
            createTime: {
                type: Sequelize.INTEGER,
                allowNull: false
            } //企业创建时间
            // recordId: {
            //     //下载表id
            //     type: Sequelize.INTEGER,
            //     allowNull: false,
            //     defaultValue: 1
            // }
        },
        {
            // //使用自定义表名
            // freezeTableName: 'tb_enterprise',
            //去掉默认的添加时间和更新时间
            timestamps: false
        }
    )
    Accout.removeAttribute('recordId')
    // var result = await sequelize.sync()
    // return result.models
    return sequelize
}
