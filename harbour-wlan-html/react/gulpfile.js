var gulp     = require('gulp'),
sass         = require('gulp-sass'),
connect      = require('gulp-connect'),
inlinesource = require('gulp-inline-source'),
img64 = require('gulp-img64'),
uglify      = require('gulp-uglify');
 

gulp.task('connect', function() {
  connect.server({
    root: ['./'],
    port: 1339,
    livereload: true});
});

gulp.task('html', function () {
  return gulp.src('app/*.html')
    .pipe(connect.reload());
});

gulp.task('sass', function () {
  return gulp.src('app/style/**/*.scss')
    .pipe(sass())
    .pipe(gulp.dest('./app/style'))
    .pipe(connect.reload());
});


//gulp.task('scripts', function() {
//  gulp.src(['./app/js/**/*.js',
//           '!./app/js/**/*.ugly.js'])
//    .pipe(uglify())
//    .pipe(gulp.dest('./app/js/**/*.ugly.js'))
// });


gulp.task('watch', function () {
  gulp.watch([ 'app/**/*.scss'], ['sass']);
  gulp.watch(['app/*.html', 'app/**/*.css', 'app/**/*.js'], ['html', 'dist']);
  //gulp.watch(['app/js/**/*.js', '!app/js/all.js'], ['scripts']);
});

gulp.task('dist', function () {
    return gulp.src('./app/*.html')
        //.pipe(inlinesource())
        .pipe(img64())
        .pipe(gulp.dest('./dist'));
});

gulp.task('dist-js', function () {
    return gulp.src('./app/js/**/*.*')
        .pipe(gulp.dest('./dist/js'));
});

gulp.task('dist-style', function () {
    return gulp.src('./app/style/**/*.css')
        .pipe(gulp.dest('./dist/style'));
});

gulp.task('export-copy', function(){
  gulp.src('dist/index.html')
    .pipe(gulp.dest('../harbour-wlan-keyboard/'));
});

gulp.task('export', ['default', 'export-copy']);

gulp.task('default', ['connect', 'sass', 'watch', 'dist', 'dist-js', 'dist-style']);
