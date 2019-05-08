var gulp = require('gulp');
// var combiner = require('stream-combiner2');
var postcss      = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var minify=require('gulp-minify-css');
var uglify=require('gulp-uglify');
gulp.task('autoprefixer', function () {
  return gulp.src('./css/*.css')
    .pipe(postcss([ autoprefixer({ browsers: ['last 2 versions'] }) ]))
    .pipe(gulp.dest('./dist/fixerCss'));
});
// gulp.task('js', function() {
//   var combined = combiner.obj([
//     gulp.src('js/*.js'),
//     uglify(),
//     gulp.dest('dist/js')
//   ]);
//   // 任何在上面的 stream 中发生的错误，都不会抛出，
//   // 而是会被监听器捕获
//   combined.on('error', console.error.bind(console));

//   return combined;
// });
gulp.task('minifyjs',function(){
  return gulp.src('js/*.js')
  .pipe(uglify())
  .pipe(gulp.dest('dist/js/'))   
})
gulp.task('minifycss', function() {
  return gulp.src('css/*.css')      //压缩的文件
  .pipe(minify())
      .pipe(gulp.dest('dist/css/'))   //输出文件夹
});
gulp.task('default', ['minifyjs', 'autoprefixer','minifycss'],function(){
  console.log(111)
});