let path = require('path')
var fs = require('fs-extra')
class Upload {
    constructor() {
        let { Accout, Record } = app.db.sqlite.models
        this.Record = Record
    }
    async upload(ctx) {
        if (ctx.method.toLowerCase() == 'options') {
            return {
                code: 200
            }
        }

        let reqParams = ctx.request.body
        let file = ctx.request.files['file']
        let sourcePath = file.path
        let name = Date.now()
        let targetPath = `/static/images/${name}.png`

        var readStream = fs.createReadStream(sourcePath)
        var writeStream = fs.createWriteStream(app.root + targetPath)
        readStream.pipe(writeStream)
        readStream.on('end', function() {
            fs.unlinkSync(sourcePath)
        })
        writeStream.end()
        // fs.renameSync(sourcePath, targetPath)
        return {
            code: 200,
            result: {
                sourcePath,
                targetPath
            }
        }
    }
    async sliceUpload(ctx) {
        let { files, index, total, name, shardSize, userId } = ctx.input_params
        let file = files.data,
            tmp = path.join(app.static, `/temp/${name}${index}`), //临时bolb文件新名字
            pathUrl = path.join(app.static, `/uploads/${name}`) //上传文件存放位置和名称
        if (fs.existsSync(pathUrl)) return { code: 301, info: '文件已经存在' }
        let exits = await this.Record.findOne({ where: { fileName: name } })
        if (!exits) {
            exits = await this.Record.create({
                fileName: name,
                status: 0,
                startIndex: index,
                endIndex: index,
                shardSize,
                userId
            })
        }
        fs.moveSync(file.path, tmp)
        try {
            if (index == total) {
                //当最后一个分片上传成功，进行合并
                if (!fs.existsSync(pathUrl)) {
                    pathUrl = path.join(
                        app.static,
                        `/uploads/${Date.now()}${name}`
                    )
                }
                console.info('上传文件：' + pathUrl)
                var writeStream = fs.createWriteStream(pathUrl)
                var aname = []
                for (let i = 1; i <= total; i++) {
                    let url = path.join(app.static, `/temp/${name}${i}`)
                    let data = fs.readFileSync(url)
                    //把数据写入流里
                    writeStream.write(data)
                    //删除生成临时bolb文件
                    fs.unlinkSync(url)
                }
                writeStream.end()
                let reuslt = this.Record.update(
                    {
                        status: 2,
                        endIndex: index
                    },
                    {
                        where: {
                            id: exits.id
                        }
                    }
                )
                return {
                    code: 0,
                    index,
                    total,
                    msg: '上传成功'
                }
            } else {
                let reuslt = this.Record.update(
                    {
                        status: 1,
                        endIndex: index
                    },
                    {
                        where: {
                            id: exits.id
                        }
                    }
                )
                return {
                    code: 1,
                    index,
                    name,
                    msg: '继续上传'
                }
            }
        } catch (error) {
            return error
        }
        // var multiparty = require('multiparty') //文件上传模块
        // var form = new multiparty.Form() //新建表单
        // //设置编辑
        // form.encoding = 'utf-8'
        // //设置文件存储路径
        // form.uploadDir = 'temp/' // "Uploads/";
        //设置单文件大小限制
        // form.maxFilesSize = 200 * 1024 * 1024;
        /*form.parse表单解析函数，fields是生成数组用获传过参数，files是bolb文件名称和路径*/
        // try {
        //     let [fields, files] = await new Promise((resolve, reject) => {
        //         form.parse(req, (err, fields, files) => {
        //             if (err) reject('test err' + JSON.stringify(err))
        //             resolve([fields, files])
        //         })
        //     })

        //     files = files['data'][0] //获取bolb文件
        //     var index = fields['index'][0] //当前片数
        //     var total = fields['total'][0] //总片数
        //     var name = fields['name'][0] //文件名称
        //     var url = 'temp/' + name + index //临时bolb文件新名字
        //     fs.renameSync(files.path, url) //修改临时文件名字

        //     var pathname = 'Uploads/' + name //上传文件存放位置和名称
        //     if (index == total) {
        //         //当最后一个分片上传成功，进行合并
        //         // 检查文件是存在，如果存在，重新设置名称
        //         let NonExist = await new Promise((resolve, reject) => {
        //             fs.access(pathname, fs.F_OK, err => {
        //                 resolve(err)
        //             })
        //         })
        //         if (!NonExist) {
        //             var myDate = Date.now()
        //             pathname = 'Uploads/' + myDate + name
        //         }
        //         logs.info('上传文件：' + pathname)
        //         /*进行合并文件，先创建可写流，再把所有BOLB文件读出来，
        //               流入可写流，生成文件
        //               fs.createWriteStream创建可写流
        //               aname是存放所有生成bolb文件路径数组:
        //               ['Uploads/3G.rar1','Uploads/3G.rar2',...]
        //           */
        //         var writeStream = fs.createWriteStream(pathname)
        //         var aname = []
        //         for (let i = 1; i <= total; i++) {
        //             let url = 'temp/' + name + i
        //             let data = await new Promise(function(resolve, reject) {
        //                 fs.readFile(url, function(error, data) {
        //                     if (error) reject(error)
        //                     resolve(data)
        //                 })
        //             })
        //             //把数据写入流里
        //             writeStream.write(data)
        //             //删除生成临时bolb文件
        //             fs.unlink(url, () => {})
        //         }
        //         writeStream.end()
        //         //返回给客服端，上传成功
        //         var data = JSON.stringify({
        //             code: 0,
        //             msg: '上传成功'
        //         })
        //         res.send(data) //返回数据
        //     } else {
        //         //还没有上传文件，请继续上传
        //         var data = JSON.stringify({
        //             code: 1,
        //             msg: '继续上传'
        //         })
        //         res.send(data) //返回数据
        //     }
        // } catch (e) {
        //     logs.info(e)
        //     res.send(e) //返回数据
        // }
    }
}

module.exports = new Upload()
