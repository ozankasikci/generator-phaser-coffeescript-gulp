del            = require 'del'
gulp           = require 'gulp'
watch          = require 'gulp-watch'
source         = require 'vinyl-source-stream'
buffer         = require 'vinyl-buffer'
plugins        = require('gulp-load-plugins')()
browserify     = require 'browserify'
browserSync    = require 'browser-sync'
mainBowerFiles = require 'main-bower-files'


paths =
  appDir       : 'app'
  appLib       : 'app/lib'
  appStyles    : 'app/styles'
  appAssets    : 'app/assets'
  appScripts   : 'app/scripts'

  buildDir     : 'build'
  buildLib     : 'build/lib'
  buildStyles  : 'build/styles'
  buildAssets  : 'build/assets'
  buildScripts : 'build/scripts'


gulp.task 'clean', (cb) ->

  del [paths.buildDir], cb



gulp.task 'watchChanges', ->

  deleteFileFromBuildDir = (event, path) ->
    return  unless event is 'deleted'
    # replacing app folder with build
    path = path.replace '/app/', '/build/'
    del [path], ->


  watchFiles = (path, gulpTask) ->

    gulp.watch [path], (file) ->
      gulp.start gulpTask
      deleteFileFromBuildDir file.type, file.path

  watchFiles "#{paths.appAssets}/**",           'copyAssets'
  watchFiles "#{paths.appStyles}/**",           'copyStyles'
  watchFiles "#{paths.appDir}/**/*.html",       'copyHtml'
  watchFiles "#{paths.appScripts}/**/*.coffee", 'coffeeify'


gulp.task 'copyPhaserFiles', ->

  gulp
    .src([
      "#{paths.appLib}/phaser-official/build/phaser.min.js",
      "#{paths.appLib}/phaser-official/build/phaser.map"
    ])
    .pipe gulp.dest paths.buildLib


gulp.task 'copyHtml', ->

  gulp
    .src "#{paths.appDir}/*.html"
    .pipe gulp.dest paths.buildDir


gulp.task 'copyAssets', ->

  gulp
    .src "#{paths.appAssets}/**/*"
    .pipe gulp.dest paths.buildAssets


gulp.task 'copyStyles', ->

  gulp
    .src "#{paths.appStyles}/**/*"
    .pipe gulp.dest paths.buildStyles


gulp.task 'coffeeify', ->

  bundledStream = browserify.bundle()
    entries    : "#{paths.appScripts}/game.coffee"
    debug      : on
    transform  : ['coffeeify']
    extensions : ['.coffee']

  bundledStream
    .pipe source "#{paths.appScripts}/game.coffee"
    .pipe buffer()
    .pipe plugins.rename 'game.js'
    .pipe gulp.dest "#{paths.buildDir}/scripts"


gulp.task 'browserSync', ['build'], ->

  browserSync.init ["#{paths.buildDir}/**"],
    server   :
      baseDir: paths.buildDir


gulp.task 'build', ['copyPhaserFiles', 'coffeeify', 'copyHtml', 'copyAssets', 'watchChanges'], ->

  gulp
    .src "#{paths.buildDir}/**/*"
    .pipe plugins.size
      title : 'build'
      gzip  : true


gulp.task 'default', ['clean'], ->

  gulp.start 'browserSync'

