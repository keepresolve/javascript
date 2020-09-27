// import xlsx from 'node-xlsx'
let path = require('path')
let fs = require('fs'),
    PDFParser = require('pdf2json'),
    nodeExcel = require('excel-export')

let pdfParser = new PDFParser()

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
        let { allRows, rows, arr, obj } = loadPDFR
        const data = this.generatorWord(arr, allRows)
        const error = await this.writeXLXS(data, file.name)
        if (error) return { code: 500, error }
        // ctx.set('Content-Type', 'application/vnd.openxmlformats')
        // ctx.set('Content-Disposition', 'attachment; filename=' + 'Report.xlsx')
        return {
            code: 200,
            allRows,
            rows,
            arr,
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
                    if (content == text) {
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
            oRow.contentArr = allKeys.map(v => {
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
    generatorWord(rows, allRows) {
        const nameRow = this.getRows('申请人', allRows)
        const name = nameRow
            ? nameRow['contentArr'][1]
                ? nameRow['contentArr'][1]['text']
                : ''
            : ''
        let cols = [
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
        let conf = {
            name: 'mysheet',
            cols: cols.map((v, i) => {
                return {
                    caption: v,
                    type: v == '餐费' ? 'number' : 'string',
                    beforeCellWrite: function(row, cellData) {
                        return cellData || ''
                    },
                    width: v == '日期' || v == '加班时间' ? 40 : 20
                }
            }),
            rows: rows.map(v => {
                v[0] = name || v[0]
                return v
            })
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
            pdfParser.on('pdfParser_dataError', errData => resolve(false))
            pdfParser.on('pdfParser_dataReady', pdfData => {
                // fs.writeFile('./pdf2json/test/F1040EZ.json', JSON.stringify())
                // resolve(pdfParser.getRawTextContent())
                let rows = {}
                let allRows = {}
                let obj = this.transferData(pdfData.formImage.Pages)
                obj.forEach(v => {
                    v.Texts.map(v => {
                        if (!allRows[`${v.y}_${v.x}`]) {
                            let str = (v.R || []).map(s => s.T).join()
                            allRows[`${v.y}_${v.x}`] = v
                            if (/^加班时间(\d).*$/.test(str))
                                rows[str] = {
                                    x: v.x,
                                    y: v.y,
                                    text: (v['R'] || []).map(j => j.T).join()
                                }
                        }
                    })
                })
                let keys = Object.keys(allRows)
                for (const key in rows) {
                    if (rows.hasOwnProperty(key)) {
                        const row = rows[key]
                        const allKeys = keys.filter(
                            v => v.split('_')[0] == row.y
                        )
                        row.contentArr = allKeys.map(v => {
                            const current = allRows[v]
                            return {
                                x: current.x,
                                y: current.y,
                                text: (current['R'] || []).map(j => j.T).join()
                            }
                        })
                        const hours = parseFloat(row.contentArr[3]['text']) //加班时长
                        const beginDate = row.contentArr[1]['text']
                        const endDate = row.contentArr[2]['text']
                        const day = beginDate.slice(0, 10) //加班日期
                        const beginTime = beginDate.slice(-5) //加班开始时间
                        const endTime = endDate.slice(-5) //加班开始时间
                        row.contentArr[1]['text'] = String(
                            day.replace(/-/g, '/')
                        )
                        row.contentArr[2]['text'] = beginTime + '-' + endTime
                        row.contentArr[4]['text'] = String(
                            hours > 1 ? (hours >= 8 ? 40 : 20) : 0
                        )
                    }
                }
                let arr = Object.keys(rows).map(v => {
                    return rows[v]['contentArr'].map(j => j.text)
                })

                resolve({ allRows, rows, arr, obj })
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
