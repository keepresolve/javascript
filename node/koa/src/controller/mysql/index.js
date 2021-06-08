let db = require('../../database/mysql')
module.exports = {
    async query(ctx) {
        let result = await db.query(ctx.input_params.query)
        return result
    },
    // async sequery(ctx) {
    //     const { seqMysql } = app.db
        
    //     let result = await seqMysql.query(ctx.input_params.query)
    //     return result
    // },
    async find(){
        // const { seqMysql } = app.db
        // const users = await seqMysql.user.findAll();
        // // const s = {...users[0].dataValues}
        // delete s.id
        // // delete s.password_hash
        // const jane = await  seqMysql.user.create(s);
        // return await seqMysql.user.findAll()
        
    }
  
}
