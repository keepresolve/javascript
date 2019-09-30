let path = require('path')
var fs = require('fs-extra')
class Download {
    async stream(ctx) {
        let reqParams = ctx.request.body
        var filePath = path.join(app.root, '/static/images/1561361949835.png')
        var stats = fs.statSync(filePath)
        var isFile = stats.isFile()
        if (isFile) {
            fs.readFile(filePath, function(isErr, data) {
                if (isErr) {
                    return { code: 500, err: isErr }
                }
                // ctx.response.set({
                //     'Content-Type': 'application/octet-stream', //告诉浏览器这是一个二进制文件
                //     'Content-Disposition':
                //         'attachment; filename=1561361949835.png', //告诉浏览器这是一个需要下载的文件
                //     'Content-Length': stats.size //文件大小
                // })
                ctx.response.attachment([filename], [options])
                return data
            })
        } else {
            return { code: 500, err: '404' }
        }
    }
}
module.exports = new Download()
