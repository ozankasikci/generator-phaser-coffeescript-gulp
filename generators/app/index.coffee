path        = require 'path'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'
_s          = require 'underscore.string'

module.exports = generators.Base.extend

  initializing : ->


  install : ->

    @installDependencies()


  prompting : ->

    done = @async()

    @log yosay(
      "Welcome to the amazing #{chalk.green('Phaser-Coffeescript')} generator!"
    )

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
        default : '^2.4.2'
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
        { centerApp : @props.centerApp, appWidth : @props.appWidth }
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

    bower : ->

      @fs.copy @templatePath('bowerrc'),     @destinationPath('.bowerrc')
      @fs.copyTpl(
        @templatePath('_bower.json'), @destinationPath('bower.json'),
        { phaserVersion : @props.phaserVersion }
      )


    npm : ->

      @fs.copyTpl(
        @templatePath('_package.json'), @destinationPath('package.json'),
        { appName : @props.appName }
      )


    gulpFile : ->

      @fs.copy @templatePath('_gulpfile.coffee'), @destinationPath('gulpfile.coffee')


  end : ->

    @log chalk.green('Yeoman has completed his mission successfully!')
    @log chalk.gray('Type `gulp` to start developing some awesome games!')


