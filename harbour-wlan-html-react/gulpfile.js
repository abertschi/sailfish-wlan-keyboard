var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var reactify = require('reactify');
var watchify = require('watchify');
var connect = require('gulp-connect');
var sass = require('gulp-sass');
var inlinesource = require('gulp-inline-source');
var img64 = require('gulp-img64');
var gulpif = require('gulp-if');
var argv = require('yargs').argv;
var uglify = require('gulp-uglify');
var streamify = require('gulp-streamify');

// live reload
gulp.task('connect', function () {
    connect.server({
        root: ['./'],
        port: 1337,
        livereload: true
    });
});

// browserify with watchify to continuously create bundle.js
gulp.task('browserify', function () {
    var browserifyBundle = browserify(
        {
            entries: ['./js/app.js'],
            transform: [reactify],
            debug: !argv.release,
            cache: {}, packageCache: {}, fullPaths: false
        }
    );
    var watcher = watchify(browserifyBundle);

    return watcher
        .on('update', function () {
            console.log('Updating changes');
            watcher.bundle().pipe(source('bundle.js'))
                .pipe(gulp.dest('./js/'));
        })
        .bundle() // Create the initial bundle when starting the task
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./js/'));
});

// styles
gulp.task('sass', function () {
    return gulp.src('css/**/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('./css'));
});


// create single file in ./dist if --release given
gulp.task('dist', function () {
    return gulp.src('*.html')
        .pipe(gulpif(argv.release, inlinesource()))
        .pipe(gulpif(argv.release, img64()))
        .pipe(gulp.dest('./dist'))
        //.pipe(gulpif(argv.release, streamify(uglify())))
        .pipe(connect.reload());
});

gulp.task('watch', function () {
    gulp.watch(['./**/*.scss'], ['sass']);
    gulp.watch(['./*.html', './**/*.css', './js/bundle.js'], ['dist']);
});


gulp.task('default', ['browserify', 'watch', 'connect']);