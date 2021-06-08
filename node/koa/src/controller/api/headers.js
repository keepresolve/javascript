let path = require('path')
var fs = require('fs-extra')

class HeadersApi {
    getClientIP(ctx) {
        return {
            code: 200,
            ip:
                ctx.request.ip ||
                ctx.request.headers['x-forwarded-for'] ||
                ctx.request.headers['x-real-ip']
        }
    }
}
module.exports = HeadersApi
