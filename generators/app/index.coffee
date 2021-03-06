_s          = require 'underscore.string'
path        = require 'path'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'

module.exports = generators.Base.extend

  initializing : ->

    @log yosay(
      "Welcome to the amazing #{chalk.green('Phaser-Coffeescript-Gulp')} generator!"
    )


  install : ->

    @installDependencies()


  prompting : ->

    done = @async()

    @prompt [
      {
        type: 'input'
        name: 'appName'
        message: 'Enter your app name'
        default : this.appname
      }
      {
        type: 'input'
        name: 'phaserVersion'
        message: 'Which Phaser version do you want to use?'
        default : '^2.8.0'
      }
      {
        type: 'input'
        name: 'appWidth'
        message: 'Enter desired canvas width'
        default : 640
      }
      {
        type: 'input'
        name: 'appHeight'
        message: 'Enter desired canvas height'
        default : 480
      }
      {
        type: 'confirm'
        name: 'centerApp'
        message: 'Would you like canvas to be centered?'
        default : false
      }
    ], (props) =>
      props.appName = _s.slugify props.appName
      @props = props
      done()


  configuring : ->


  default : ->


  writing :

    app : ->
      @fs.copyTpl(
        @templatePath('_index.html'), @destinationPath('app/index.html'),
        { appName : @props.appName }
      )

      @fs.copyTpl(
        @templatePath('styles/style.css'), @destinationPath('app/styles/style.css'),
        { centerApp : @props.centerApp, appWidth : @props.appWidth, appHeight : @props.appHeight }
      )

      @fs.copy @templatePath('assets/**'),                     @destinationPath('app/assets')
      @fs.copy @templatePath('scripts/states/boot.coffee'),    @destinationPath('app/scripts/states/boot.coffee')
      @fs.copy @templatePath('scripts/states/menu.coffee'),    @destinationPath('app/scripts/states/menu.coffee')
      @fs.copy @templatePath('scripts/states/main.coffee'),    @destinationPath('app/scripts/states/main.coffee')
      @fs.copy @templatePath('scripts/states/preload.coffee'), @destinationPath('app/scripts/states/preload.coffee')

      @fs.copyTpl(
        @templatePath('scripts/game.coffee'), @destinationPath('app/scripts/game.coffee'),
        { width : @props.appWidth, height : @props.appHeight }
      )


    npm : ->

      @fs.copyTpl(
        @templatePath('_package.json'), @destinationPath('package.json'),
        { appName : @props.appName, phaserVersion: @props.phaserVersion }
      )


    gulpFile : ->

      @fs.copy @templatePath('_gulpfile.coffee'), @destinationPath('gulpfile.coffee')


  end : ->

    @log chalk.green('Yeoman has completed his mission successfully!')
    @log chalk.gray('Install gulp `npm i gulp -g` if needed and run `gulp` to start developing some awesome games!')
