path        = require 'path'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'

module.exports = generators.Base.extend

  initializing : ->


  prompting : ->

    done = @async()

    @log yosay(
      "Welcome to the amazing #{chalk.green('Phaser-Coffeescript')} generator!"
    )

    @prompt [
      {
        type: 'input'
        name: 'appName'
        message: 'Your app name?'
        default : this.appname
      }
      {
        type: 'input'
        name: 'appWidth'
        message: 'Your app width?'
        default : 640
      }
      {
        type: 'input'
        name: 'appHeight'
        message: 'Your app height?'
        default : 480
      }
    ], (props) =>
      @props = props
      done()



  configuring : ->


  default : ->


  writing :

    app : ->
      @fs.copyTpl(
        @templatePath('_index.html'), @destinationPath('app/index.html'),
        { appName: @props.appName }
      )

      @fs.copy @templatePath('assets/**'),                     @destinationPath('app/assets')
      @fs.copy @templatePath('styles/**'),                     @destinationPath('app/styles')
      @fs.copy @templatePath('scripts/states/boot.coffee'),    @destinationPath('app/scripts/boot.coffee')
      @fs.copy @templatePath('scripts/states/menu.coffee'),    @destinationPath('app/scripts/menu.coffee')
      @fs.copy @templatePath('scripts/states/main.coffee'),    @destinationPath('app/scripts/main.coffee')
      @fs.copy @templatePath('scripts/states/preload.coffee'), @destinationPath('app/scripts/preload.coffee')

      @fs.copyTpl(
        @templatePath('scripts/game.coffee'), @destinationPath('app/scripts/game.coffee'),
        { width : @props.appWidth, height : @props.appHeight }
      )

    bower : ->

      @fs.copy @templatePath('_bower.json'), @destinationPath('bower.json')
      @fs.copy @templatePath('bowerrc'),     @destinationPath('.bowerrc')


    npm : ->

      @fs.copyTpl(
        @templatePath('_package.json'), @destinationPath('package.json'),
        { appName: @props.appName }
      )


    gulpFile : ->

      @fs.copy @templatePath('_gulpfile.coffee'), @destinationPath('gulpfile.coffee')


  install : ->

    @installDependencies()


  end : ->



