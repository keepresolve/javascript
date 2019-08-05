let db = require('../../database/mysql')
module.exports = {
    async query(ctx) {
        console.log(ctx.input_params)
        let result = await db.query(ctx.input_params.query)
        return result
    }
}
