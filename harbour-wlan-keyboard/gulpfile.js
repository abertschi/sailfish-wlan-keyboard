var gulp     = require('gulp');
var gutil = require('gutil');


var gulpSSH = require('gulp-ssh')({
  ignoreErrors: false,
  sshConfig: {
    host: '192.168.2.15',
    port: 22,
    username: 'nemo',
    privateKey: require('fs').readFileSync('/Users/abertschi/.ssh/id_rsa')
  }
});
 
// execute commands 
gulp.task('exec', ['sync-files'], function () {
  gulpSSH.exec(['sailfish-qml harbour-wlan-keyboard']);
});

/*
 * sftp mount of qml directory for easy prototyping
 */
var qmlJollaMount = "/Users/abertschi/sshfs/jolla/usr/share/harbour-wlan-keyboard/qml";
var watch = [
    './qml/**/*.*',
    './index.html'];


gulp.task('sync-files', function () {
  return gulp.src(watch)
          .pipe(gulp.dest(qmlJollaMount));
});

gulp.task('watch', function () {
  gulp.watch(watch, ['exec']);
});

gulp.task('default', ['exec', 'watch']);

