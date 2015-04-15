gulp = require 'gulp'
slim = require 'gulp-slim'
coffee = require 'gulp-coffee'
bower = require 'main-bower-files'

paths =
  coffee: './src/js/*.coffee'
  slim: './src/html/*.slim'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee()
    .pipe gulp.dest 'build/js'

gulp.task 'slim', ->
  gulp.src  paths.slim
    .pipe slim pretty: true
    .pipe gulp.dest 'build/html'

gulp.task 'bower', ->
  gulp.src bower()
    .pipe gulp.dest 'build/js/lib'

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['coffee'])
  gulp.watch(paths.slim, ['slim'])

gulp.task 'default', ['coffee', 'slim', 'bower', 'watch']
