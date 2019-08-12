const Excel = require("exceljs");
let path = require("path");
//文件的实例
var workbook = new Excel.Workbook();
//读取xlsx的文件 如果是csv文件就把xlsx改成csv
//change path
workbook.xlsx
  .readFile(path.resolve(__dirname, "./新架构Bug处理方案.xlsx"))
  .then(function() {
    //选择表 可以根据表的名字选取
    //change sheetname
    let worksheet = workbook.getWorksheet(1);
    //获取单元格
    //s1是Excel表中的C8单元格
    //s2是Excel表中的G2单元格
    //   let s1 = worksheet.getRow(6).getCell(2).value;
    //   let s2 = worksheet.getRow(2).getCell(5).value;

    console.log(worksheet); //1
    // var dobCol = worksheet.getColumn(3);
    // dobCol.eachCell(function(cell, rowNumber) {
    //   console.log(cell, rowNumber);
    // });
    // dobCol.eachCell({ includeEmpty: true }, function(cell, rowNumber) {
    //   // ...
    // });
    // 迭代工作表中的所有行（包括空行）
    var sheet = workbook.addWorksheet("My Sheet", {
      properties: { tabColor: { argb: "FFC0000" } }
      //   columns: [
      //     { header: "Id", key: "id", width: 10 },
      //     { header: "Name", key: "name", width: 32 },
      //     { header: "D.O.B.", key: "DOB", width: 10, outlineLevel: 1 }
      //   ]
    });
    // sheet.columns = [
    //   { header: "Id", key: "id", width: 10 },
    //   { header: "Name", key: "name", width: 32 },
    //   { header: "D.O.B.", key: "DOB", width: 10, outlineLevel: 1 }
    // ];
    worksheet.eachRow({ includeEmpty: true }, function(row, rowNumber) {
      console.log("Row " + rowNumber + " = " + JSON.stringify(row.values));
      //   if (row.getCell("E").value != "CM" && rowNumber > 2) row.hidden = true;

      if (rowNumber != 2) {
        if (row.getCell("E").value == "CM") {
          sheet.addRow(row.values);
        }
      } else {
        sheet.columns = row.values;
      }
    });

    //   console.log(s2); //2
    //给单元格赋值
    //   worksheet.getRow(3).getCell(4).value = 666;
    //写文件 会在newpath路径下生成一个新的Excel文件 会保留样式
    // change new path
    workbook.xlsx.writeFile(path.resolve(__dirname, "./bug.xlsx"));
  });
