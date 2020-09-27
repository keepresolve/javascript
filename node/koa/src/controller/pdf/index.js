// import xlsx from 'node-xlsx'
let path = require('path')
let fs = require('fs'),
    PDFParser = require('pdf2json'),
    nodeExcel = require('excel-export')



class PDF {
    constructor() {}
    async transform(ctx) {
        if (ctx.method.toLowerCase() == 'options') {
            return {
                code: 200
            }
        }
        // let reqParams = ctx.request.body
        let file = ctx.request.files['file']
        let loadPDFR = await this.loadPDF(file)
        if (!loadPDFR) return { code: 500, msg: '加载pdf失败' }
        let { allRows, cols, obj } = loadPDFR
        const data = this.generatorWord(cols, allRows)
        const error = await this.writeXLXS(data, file.name)
        if (error) return { code: 500, error }
        ctx.set('Content-Type', 'application/vnd.openxmlformats')
        ctx.set('Content-Disposition', 'attachment; filename=' + 'Report.xlsx')
        return {
            code: 200,
            allRows,
            // rows,
            cols,
            obj,
            url: `http://${ctx.headers.host}/jiaban/${file.name}.xlsx`
        }
        // return { code: 200, allRows, rows }
    }
    getRows(text, allRows) {
        let oRow = {}
        for (const key in allRows) {
            if (allRows.hasOwnProperty(key)) {
                let row = allRows[key]
                if (row['R']) {
                    let content = row['R'].map(v => v.T).join()
                    content = content ? content.replace(/ /g, '') : ''
                    text = text ? text.replace(/ /g, '') : ''
                    if (content.search(text) != -1) {
                        Object.assign(oRow, {
                            x: row.x,
                            y: row.y,
                            text: content
                        })
                    }
                }
            }
        }
        if (oRow.y) {
            const allKeys = Object.keys(allRows).filter(
                v => v.split('_')[0] == oRow.y
            )
            oRow.rowArr = allKeys.map(v => {
                const current = allRows[v]
                return {
                    x: current.x,
                    y: current.y,
                    text: (current['R'] || []).map(j => j.T).join()
                }
            })
        }
        return oRow
    }
    generatorWord(cols, allRows) {
        const nameRow = this.getRows('申请人', allRows)
        const name = nameRow
            ? nameRow['rowArr'][1]
                ? nameRow['rowArr'][1]['text']
                : ''
            : ''
        let columnName = [
            '姓名',
            '日期',
            '加班时间',
            '加班时长',
            '餐费',
            '交通费',
            '出发地',
            '到达地',
            '其他'
        ]

        const beiginCont = cols['开始时间']['content']
        const endinCont = cols['结束时间']['content']
        const hours = cols['时长']['content']
        let rows = hours.map((v, index) => {
            return [
                name,
                beiginCont[index].slice(0, 10),
                `${beiginCont[index].slice(-5)}-${endinCont[index].slice(-5)}`,
                v,
                v >= 8 ? '40' : '20'
            ]
        })
        let conf = {
            name: 'mysheet',
            cols: columnName.map((v, i) => {
                return {
                    caption: v,
                    type: v == '餐费' ? 'number' : 'string',
                    beforeCellWrite: function(row, cellData) {
                        return cellData || ''
                    },
                    width: v == '日期' || v == '加班时间' ? 40 : 20
                }
            }),
            rows
        }
        console.log('申请人', nameRow)
        let data = nodeExcel.execute(conf)
        return data
        // return new Buffer(data, 'binary')
        // conf.rows = []
        // var result = nodeExcel.execute(conf)
        // res.setHeader('Content-Type', 'application/vnd.openxmlformats')
        // res.setHeader(
        //     'Content-Disposition',
        //     'attachment; filename=' + 'Report.xlsx'
        // )
        // res.end(result, 'binary')
    }
    loadPDF(file) {
        return new Promise(resolve => {
            let pdfParser = new PDFParser()
            pdfParser.on('pdfParser_dataError', errData => resolve(false))
            pdfParser.on('pdfParser_dataReady', pdfData => {
                // fs.writeFile('./pdf2json/test/F1040EZ.json', JSON.stringify())
                // resolve(pdfParser.getRawTextContent())
                let cols = {}
                let allRows = {}
                let obj = this.transferData(pdfData.formImage.Pages)
                obj.forEach(v => {
                    v.Texts.map(v => {
                        if (!allRows[`${v.y}_${v.x}`]) {
                            let str = (v.R || []).map(s => s.T).join()
                            allRows[`${v.y}_${v.x}`] = v
                            if (/^(开始时间|结束时间|时长|加班原因)$/.test(str))
                                cols[str] = {
                                    x: v.x,
                                    y: v.y,
                                    text: (v['R'] || []).map(j => j.T).join()
                                }
                        }
                    })
                })

                let keys = Object.keys(allRows)
                let begingY = cols['开始时间']['y']
                let endRow = this.getRows('总时长', allRows)
                let endY = endRow['y']
                for (const key in cols) {
                    if (cols.hasOwnProperty(key)) {
                        let currentCol = cols[key]
                        const allKeys = keys.filter(v => {
                            let X = v.split('_')[1]
                            let Y = v.split('_')[0]
                            return (
                                X == currentCol['x'] && Y < endY && begingY < Y
                            )
                        })
                        let contentText = ''
                        currentCol['cols'] = allKeys.map(v => {
                            const content = allRows[v]
                            const text = (content['R'] || [])
                                .map(j => j.T)
                                .join()
                            contentText += text
                            return {
                                x: content.x,
                                y: content.y,
                                text
                            }
                        })
                        cols[key]['content'] = []
                        let length = contentText.length
                        let start = 0
                        // |结束时间|时长|加班原因
                        if (key == '开始时间' || key == '结束时间') {
                            while (start + 10 < length) {
                                cols[key]['content']['push'](
                                    contentText.slice(start, start + 16)
                                )
                                start += 16
                            }
                        }
                        if (key == '时长') {
                            cols[key]['content'] = contentText.split('小时')
                            cols[key]['content'].length =
                                cols[key]['content'].length - 1
                        }
                        cols['contentText'] = contentText
                    }
                }

                resolve({ allRows, cols, obj })
            })
            
            pdfParser.loadPDF(file.path)
        })
    }
    transferData(data) {
        let type = Object.prototype.toString.call(data)
        switch (type) {
            case '[object Object]':
                for (const key in data) {
                    data[key] = this.transferData(data[key])
                }
                break
            case '[object Array]':
                for (let index = 0; index < data.length; index++) {
                    data[index] = this.transferData(data[index])
                }
                break
            default:
                data = decodeURIComponent(data)
                break
        }
        return data
    }
    writeXLXS(data, fileName) {
        const writePath = path.join(
            __dirname,
            `../../../static/jiaban/${fileName}.xlsx`
        )
        return new Promise(resolve => {
            fs.writeFile(writePath, data, { encoding: 'binary' }, function(
                err
            ) {
                if (err) return resolve(err)
                resolve(null)
            })
        })
    }
}

module.exports = new PDF()
