var gulp = require('gulp');
// var combiner = require('stream-combiner2');任何在上面的 stream 中发生的错误
var del = require('del');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var cleanCSS=require('gulp-clean-css');
var uglify=require('gulp-uglify');
var rename     = require('gulp-rename');
var stripDebug = require('gulp-strip-debug');
var gulpSequence = require('gulp-sequence');
var sourcemaps = require('gulp-sourcemaps');
var concat = require('gulp-concat');
var log = require('fancy-log');
var noop = require("gulp-noop");
var replace = require('gulp-replace');
// 'gulp-requirejs' 'gulp-requirejs-optimize' 是处理AMD的插件
// 我们需要的是 http://browserify.org/ 
// https://www.viget.com/articles/gulp-browserify-starter-faq/

//  browserify 一次只能处理一个文件！处理多个文件还要再引入
//  glob       = require('node-glob'),
//  es         = require('event-stream');
// https://fettblog.eu/gulp-browserify-multiple-bundles/
// http://blog.revathskumar.com/2016/02/browserify-multiple-bundles.html
// https://github.com/gulpjs/gulp/blob/master/docs/recipes/browserify-multiple-destination.md

//shim & transform (e.g. es6=>Vanilla)
//https://github.com/browserify/browserify-handbook#shimming
//https://scotch.io/tutorials/getting-started-with-browserify

var browserify = require('browserify')
var vsource    = require('vinyl-source-stream')
var es         = require('event-stream');

//原来的实现browserify后直接pipe uglify/sourcemaps 所以要buffer
//vinyl-source-stream -> buffer 才能 uglify/sourcemaps
//目前改为'event-stream'，browserify生成临时文件，没有pipe所以不需要buffer
var buffer     = require('vinyl-buffer')

gulp.task('clean', function (cb) {
  return del([
    './tmp',
    '../node/public/user/js/*.min.js',
    '../node/public/user/css/*min.css',
    '../node/public/script.min.js'
    ],{
      force: true
    });
});

gulp.task('post', function (done) {
  gulp.src('./*.html').pipe(gulp.dest('../node/public/user'));
//https://github.com/gulpjs/gulp/blob/master/docs/API.md#async-task-support
  return del(['./tmp'])
});

//browserify一次只能处理一个文件，引入es
gulp.task('bundles', function(done) {
  var files = [
      './js/user.js',
      './script.js'
  ];
  // map them to our stream function
  var tasks = files.map(function(entry) {
    if (process.env.NODE_ENV === 'development') {
      return browserify({ entries: [entry] })
          .bundle()
          .pipe(vsource(entry))
          .pipe(gulp.dest('./tmp'));
    } else {
      //https://stackoverflow.com/questions/35220618/gulp-preserving-folder-structure-on-destination-for-individual-files
      return gulp.src(entry,{base:'.'}) //输出保留路径信息
      .pipe(replace(/var debug = require\(\'debug\'\).*/g, ''))
      .pipe(replace(/debug\(.*\)/g, ''))
      .pipe(gulp.dest('./tmp'))      
    }
  });
  //return es.merge.apply(null, tasks);
  //https://github.com/dominictarr/event-stream#merge-stream1streamn-or-merge-streamarray
  //Counts how many streams were passed to it and emits end only when all streams emitted end.
  es.merge(tasks).on('end', done);
});

gulp.task('minifyjs',function(cb){
  //src顺序很重要，先plugs.js，不然报错
  return gulp.src(['./js/plugs.js','./tmp/js/user.js'])
  .pipe(process.env.NODE_ENV === 'development' ? sourcemaps.init() : noop()) 
  .pipe(concat('bundle.js'))
  .pipe(uglify())
  .pipe(rename({suffix: '.min'}))
  .pipe(process.env.NODE_ENV === 'development' ? sourcemaps.write() : noop()) 
  .pipe(gulp.dest('../node/public/user/js'))  
})

gulp.task('minify_script', function () {
  return gulp.src('tmp/script.js') 
    .pipe(process.env.NODE_ENV === 'development' ? sourcemaps.init() : noop())
    .pipe(uglify())
    .pipe(rename({suffix: '.min'}))
    .pipe(process.env.NODE_ENV === 'development' ? sourcemaps.write() : noop()) 
    .pipe(gulp.dest('../node/public/'))  
})

gulp.task('css', function (cb) {
  return gulp.src('./css/*.css')
    .pipe(postcss([ autoprefixer({ browsers: ['last 2 versions'] }) ]))
    .pipe(cleanCSS())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest('../node/public/user/css'))   //输出文件夹
    cb(err)
});

gulp.task('default', function (done) {
  gulpSequence(
    'clean','bundles',
    ['css','minifyjs','minify_script'],
    'post',
    function () {
      log('success');
      //gulp 4.0 下'gulp-sequence' 跑不起来，只好还是3.9.1，虽然有gulp-util is deprecated
      done();
    });
})

gulp.task('buildjs', function (done) {
  gulpSequence(
    'bundles','minifyjs',
    'post',
    function () {
      log('success');
      //gulp 4.0 下'gulp-sequence' 跑不起来，只好还是3.9.1，虽然有gulp-util is deprecated
      done();
    });
})
