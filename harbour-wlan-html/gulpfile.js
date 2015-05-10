var gulp            = require('gulp');
var browserify      = require('browserify');
var source          = require('vinyl-source-stream');
var reactify        = require('reactify');
var watchify        = require('watchify');
var connect         = require('gulp-connect');
var sass            = require('gulp-sass');
var inlinesource    = require('gulp-inline-source');
var img64           = require('gulp-img64');
var gulpif          = require('gulp-if');
var argv            = require('yargs').argv;
var uglify          = require('gulp-uglify');
var streamify       = require('gulp-streamify');

var production = argv.production == true;

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
            entries: ['./app/js/app.js'],
            transform: [reactify],
            debug: ! production,
            cache: {}, packageCache: {}, fullPaths: false
        }
    );
    var watcher = watchify(browserifyBundle);

    return watcher
        .on('update', function () {
            console.log('Updating changes');
            watcher.bundle().pipe(source('bundle.js'))
                .pipe(gulp.dest('./app/js/'));
        })
        .bundle() // Create the initial bundle when starting the task
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./app/js/'));
});

// styles
gulp.task('sass', function () {
    return gulp.src('./app/css/**/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('./app/css'));
});


gulp.task('dist-html', function() {
    return gulp.src(['./app/*.html'])
        .pipe(gulp.dest('./dist'))
        .pipe(connect.reload());
});

gulp.task('dist-style', function() {
    return gulp.src(['./app/css/**/*.css'])
        .pipe(gulp.dest('./dist/css'));
        //.pipe(gulpif(argv.release, streamify(uglify())))
});

gulp.task('dist-js', function() {
    return gulp.src(['./app/js/bundle.js'])
        .pipe(gulp.dest('./dist/js'));
});

gulp.task('dist-img', function() {
    return gulp.src(['./app/img/**/*.*'])
        .pipe(gulp.dest('./dist/img'));
});


gulp.task('watch', function () {
    gulp.watch(['./app/css/**/*.scss'], ['sass']);

    if (production) {
        gulp.watch(['./app/*.html'], ['dist-html']);
        gulp.watch(['./app/css/**/*.css'], ['dist-style']);
        gulp.watch(['./app/js/bundle.js'], ['dist-js']);
        gulp.watch(['./app/img/**/*.*'], ['dist-img']);
    }
});

gulp.task('dist', ['dist-html', 'dist-style', 'dist-js', 'dist-img']);

gulp.task('default', ['browserify', 'watch', 'connect', 'dist']);