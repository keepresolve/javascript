var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    babel = require("gulp-babel");
// 1————————————————————————
// gulp.task('task-name', function() { //简单的工程任务
//     console.log("执行了...")
//   });
//  运行 gulpv task-name
// 2介绍————————————————————————
// gulp.task('task-name', function () {
//     return gulp.src('source-files') //需要操作的文件地址使用 src引入
//       .pipe(aGulpPlugin()) // pipe 拿到上面数据操作
//       .pipe(gulp.dest('destination')) // pipe可以多写  dest输出目录
//   })
// 3 压缩js——————————————————————
// gulp.task('minJS', function () {
//     return gulp.src('./app/js/*.js') //需要操作的文件地址使用 src引入
//       .pipe(uglify()) // pipe 拿到上面数据操作
//       .pipe(gulp.dest('dist/js')) // pipe可以多写  dest输出目录
//   })

// 4:es6——————————————————————  gulp-babel  babel-preset-env 
gulp.task("es6", function () {
    return gulp.src("app/es6/*.js")// ES6 源码存放的路径
      .pipe(babel({presets: ['env']}))    //.pipe(babel({presets: ['es2015']})) babel-preset-2015
      .pipe(gulp.dest("dist/es6")); //转换成 ES5 存放的路径
  });