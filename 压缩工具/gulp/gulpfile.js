var gulp = require('gulp'),
    concat = require('gulp-concat'),//- 多个文件合并为一个；  
    cleanCSS = require('gulp-clean-css'),//- 压缩CSS为一行；  
    ugLify = require('gulp-uglify'),//压缩js  
    imageMin = require('gulp-imagemin'),//压缩图片  
    pngquant = require('imagemin-pngquant'), // 深度压缩  
    htmlMin = require('gulp-htmlmin'),//压缩html  
    changed = require('gulp-changed'),//检查改变状态  
    less = require('gulp-less'),
    browserSync = require("browser-sync").create();//浏览器实时刷新  

//删除dist下的所有文件  
gulp.task('delete', function (cb) {
    return del(['dist/*'], cb);
})
function bundle(options) {
    options = options || {};

    let watch = !!options.watch;
    let bundler = browserify(
        {
            entries: path.join(__dirname, PKG.main),
            extensions: ['.js', '.jsx'],
            // required for sourcemaps (must be false otherwise)
            debug: process.env.NODE_ENV === 'development',
            // required for watchify
            cache: {},
            // required for watchify
            packageCache: {},
            // required to be true only for watchify
            fullPaths: watch,
            // Don't parse clone dep (not needed)
            noParse: ['clone']
        })
        .transform('babelify',
        {
            presets: ['es2015', 'react'],
            plugins: ['transform-runtime', 'transform-object-assign']
        })
        .transform(envify(
            {
                NODE_ENV: process.env.NODE_ENV,
                _: 'purge'
            }));

    if (watch) {
        bundler = watchify(bundler);

        bundler.on('update', () => {
            let start = Date.now();

            gutil.log('bundling...');
            rebundle();
            gutil.log('bundle took %sms', (Date.now() - start));
        });
    }

    function rebundle() {
        return bundler.bundle()
            .on('error', logError)
            .pipe(source(`${PKG.name}.js`))
            .pipe(buffer())
            .pipe(rename(`${PKG.name}.js`))
            .pipe(gulpif(process.env.NODE_ENV === 'production',
                uglify()
            ))
            .pipe(header(BANNER, BANNER_OPTIONS))
            .pipe(gulp.dest(OUTPUT_DIR));
    }

    return rebundle();
}

//压缩html  
gulp.task('html', function () {
    var options = {
        removeComments: true,//清除HTML注释  
        collapseWhitespace: true,//压缩HTML  
        collapseBooleanAttributes: true,//省略布尔属性的值 <input checked="true"/> ==> <input />  
        removeEmptyAttributes: true,//删除所有空格作属性值 <input id="" /> ==> <input />  
        removeScriptTypeAttributes: true,//删除<script>的type="text/javascript"  
        removeStyleLinkTypeAttributes: true,//删除<style>和<link>的type="text/css"  
        minifyJS: true,//压缩页面JS  
        minifyCSS: true//压缩页面CSS  
    };
    gulp.src('src/index.html')
        .pipe(changed('dist', { hasChanged: changed.compareSha1Digest }))
        .pipe(htmlMin(options))
        .pipe(gulp.dest('dist'))
        .pipe(browserSync.reload({ stream: true }));
});

//实时编译less  
gulp.task('less', function () {
    gulp.src(['./src/less/*.less']) //多个文件以数组形式传入  
        .pipe(changed('dist/css', { hasChanged: changed.compareSha1Digest }))
        .pipe(less())
        .pipe(concat('main.css'))
        .pipe(cleanCSS())
        .pipe(gulp.dest('dist/css'))//将会在css下生成main.css  
        .pipe(browserSync.reload({ stream: true }));
});

//压缩js  
gulp.task("script", function () {
    gulp.src(['src/js/*.js'])
        .pipe(changed('dist/js', { hasChanged: changed.compareSha1Digest }))
        .pipe(concat('index.js'))
        .pipe(ugLify())
        .pipe(gulp.dest('dist/js'))
        .pipe(browserSync.reload({ stream: true }));
});

// 压缩图片  
gulp.task('images', function () {
    gulp.src('./src/images/*.*')
        .pipe(changed('dist/images', { hasChanged: changed.compareSha1Digest }))
        .pipe(imageMin({
            progressive: true,// 无损压缩JPG图片  
            svgoPlugins: [{ removeViewBox: false }], // 不移除svg的viewbox属性  
            use: [pngquant()] // 使用pngquant插件进行深度压缩  
        }))
        .pipe(gulp.dest('dist/images'))
        .pipe(browserSync.reload({ stream: true }));
});
gulp.task('pro', ['delete'], function () {
    gulp.start('script', 'less', 'html', 'images');
});

//启动热更新  
gulp.task('server', ['delete'], function () {
    gulp.start('script', 'less', 'html', 'images');
    browserSync.init({
        port: 2016,
        server: {
            baseDir: ['dist']
        }
    });
    gulp.watch('src/js/*.js', ['script']);         //监控文件变化，自动更新  
    gulp.watch('src/less/*.less', ['less']);
    gulp.watch('src/*.html', ['html']);
    gulp.watch('src/images/*.*', ['images']);
});

gulp.task('default', ['pro']);  