// const XLSX = require("xlsx");

// function readAsArrayBufferPro(file, notice) {
//   return new Promise((resolve, reject) => {
//     var fileReader = new FileReader();
//     fileReader.onload = function (e) {
//       resolve(e.target.result);
//     };
//     fileReader.onerror = function (e) {
//       reject(new Error("Error reading" + file.name + ": " + e.target.result));
//     };
//     fileReader.onprogress = function () {
//       notice && notice.apply(this, [file, ...arguments]);
//     };
//     fileReader["readAsArrayBuffer"](file, 1);
//   });
// }
// function parse(files, cb) {
//   cb = Object.toString.call(cb) === "function" ? cb : function () {};
//   let filesPrgress = Array.from(files).map((file) => ({
//     progress: {},
//     ...file,
//   }));
//   function notice(file, progress) {
//     let cfile = filesPrgress.find((vfile) => vfile.name == file.name);
//     if (!cfile) return;
//     cfile.progress = progress;
//     cb(filesPrgress);
//   }
//   return Promise.all(
//     Array.from(files).map((file) =>
//       readAsArrayBufferPro(file, notice)
//         .then((data) => {
//           var workbook = XLSX.read(data, {
//             type: "buffer",
//           });
//           return Object.entries(workbook.Sheets)
//             .map(([sheetName, sheetData]) => {
//               const sheetJson = XLSX.utils.sheet_to_json(sheetData);
//               return {
//                 list: sourceJson.map((v) => ({
//                   ...v,
//                   sheetName,
//                   fileName: file.name,
//                 })),
//                 sheetJson,
//                 sheetName: sheetName,
//                 fileName: file.name,
//               };
//             })
//             .reduce(
//               (result, sheet) => {
//                 result.allSheets = result.allSheets.concat(sheet.list);
//                 result.sheets.push(sheet);
//                 return result;
//               },
//               {
//                 type: "success",
//                 allSheets: [],
//                 sheets: [],
//               }
//             );
//         })
//         .catch((err) => ({
//           type: "error",
//           message: err,
//           allSheets: [],
//           sheets: [],
//         }))
//     )
//   );
// }
function parse(){
    Promise.resolve().finally()
}

module.exports = {
  parse
};
