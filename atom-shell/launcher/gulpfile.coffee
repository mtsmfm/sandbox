gulp = require 'gulp'
slim = require 'gulp-slim'
coffee = require 'gulp-coffee'

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

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['coffee'])
  gulp.watch(paths.slim, ['slim'])

gulp.task 'default', ['coffee', 'slim', 'watch']
