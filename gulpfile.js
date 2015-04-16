var gulp = require('gulp');


gulp.task('default', function () {
    var include = require('gulp-file-include');
    var rename = require('gulp-rename');

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

gulp.task('precommit',['setBinaryVersion']);

gulp.task('setBinaryVersion',function(){
    var replace = require('gulp-replace');
    var version = require('./package.json').version;
    return gulp.src(['bin/*'])
        .pipe(replace(/version\s*:\s*'?[\w\.]+'?/,'version: \''+ version + '\''))
        .pipe(gulp.dest('bin'))
});