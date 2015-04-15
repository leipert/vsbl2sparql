var gulp = require('gulp');

var include = require('gulp-file-include');
var rename = require('gulp-rename');

gulp.task('default', function () {
    gulp.src(['tpl/**.tpl'])
        .pipe(include({
            prefix: '@@',
            basepath: './lib'
        }))
        .pipe(rename({
            extname: ".js"
        }))
        .pipe(gulp.dest('./'));
});