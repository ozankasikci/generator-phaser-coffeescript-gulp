del            = require 'del'
gulp           = require 'gulp'
source         = require 'vinyl-source-stream'
buffer         = require 'vinyl-buffer'
plugins        = require('gulp-load-plugins')()
browserify     = require 'browserify'
browserSync    = require 'browser-sync'


paths =
  appDir       : 'app'
  appLib       : 'app/lib'
  appStyles    : 'app/styles'
  appAssets    : 'app/assets'
  appScripts   : 'app/scripts'
  appPrefabDir : 'app/prefab'

  buildDir     : 'build'
  buildLib     : 'build/lib'
  buildStyles  : 'build/styles'
  buildAssets  : 'build/assets'
  buildScripts : 'build/scripts'


gulp.task 'clean', (cb) ->

  del [paths.buildDir], cb



gulp.task 'watchChanges', ->

  bs = browserSync.create()

  deleteFileFromBuildDir = (event, path) ->
    return  unless event is 'unlink' or event is 'unlinkDir'
    # replacing app folder with build
    path = path.replace 'app/', 'build/'
    # deleting the file from build directory
    del [path], ->


  watchFiles = (path, gulpTask) ->

    bs.watch path, (event, file) ->
      gulp.start gulpTask
      deleteFileFromBuildDir event, file

  watchFiles "#{paths.appAssets}/**",             'copyAssets'
  watchFiles "#{paths.appStyles}/**",             'copyStyles'
  watchFiles "#{paths.appDir}/**/*.html",         'copyHtml'
  watchFiles "#{paths.appScripts}/**/*.coffee",   'coffeeify'
  watchFiles "#{paths.appPrefabDir}/**/*.coffee", 'coffeeify'


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

  b = browserify
    entries    : "#{paths.appScripts}/game.coffee"
    debug      : on
    transform  : ['coffeeify']
    extensions : ['.coffee']

  b.bundle()
    .pipe source "#{paths.appScripts}/game.coffee"
    .pipe buffer()
    .pipe plugins.rename 'game.js'
    .pipe gulp.dest "#{paths.buildDir}/scripts"


gulp.task 'browserSync', ['build'], ->

  browserSync.init ["#{paths.buildDir}/**"],
    server   :
      baseDir: paths.buildDir


gulp.task 'build', ['coffeeify', 'copyHtml', 'copyStyles', 'copyAssets', 'watchChanges'], ->

  gulp
    .src "#{paths.buildDir}/**/*"
    .pipe plugins.size
      title : 'build'
      gzip  : off
    .pipe plugins.size
      title : 'build'
      gzip  : on


gulp.task 'default', ['clean'], ->

  gulp.start 'browserSync'

