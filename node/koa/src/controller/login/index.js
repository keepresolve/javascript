/**
 * 表
 */
/**
 *  @param  user_id
 */

class Account {
    constructor() {
        let { Accout, Record } = app.db.sqlite.models
        this.Accout = Accout
        this.Record = Record
    }
    async register(ctx) {
        let { accoutName, password } = ctx.input_params
        if (!accoutName || !password)
            return { code: 301, info: '用户名密码不能为空' }
        let exits = await this.Accout.findOne({ where: { accoutName } })
        if (exits) return { code: 301, info: '用户名已存在' }
        let result = await this.Accout.create({
            accoutName,
            password,
            createTime: Date.now()
        })
        return {
            code: 200,
            data: result
        }
    }
    async login(ctx) {
        let { accoutName, password } = ctx.input_params
        let exits = await this.Accout.findOne({
            where: { accoutName, password }
        })
        if (!exits)
            return {
                code: 301,
                info: '用户名密码错误'
            }
        return {
            code: 200,
            data: exits
        }
    }
}

module.exports = new Account()
