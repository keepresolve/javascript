let path = require('path')
var fs = require('fs-extra')
const HeadersApi = require('./headers')
module.exports = {
    headersApi: new HeadersApi()
}
