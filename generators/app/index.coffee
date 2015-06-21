path        = require 'path'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'

module.exports = generators.Base.extend

  initializing : ->


  prompting : ->

    @log yosay(
      "Welcome to the amazing #{chalk.green('Phaser-Coffeescript')} generator!"
    )


  configuring : ->


  default : ->


  writing :

    app : ->
      @fs.copyTpl(
        @templatePath('_index.html'),
        @destinationPath('app/index.html'),
        { title: 'Templating with Yeoman' }
      )

      @fs.copy @templatePath('scripts/**')  , @destinationPath('app/scripts')
      @fs.copy @templatePath('assets/**')   , @destinationPath('app/assets')
      @fs.copy @templatePath('styles/**')   , @destinationPath('app/styles')


    bower : ->

      @fs.copy @templatePath('_bower.json') , @destinationPath('bower.json')
      @fs.copy @templatePath('bowerrc')     , @destinationPath('.bowerrc')


    npm : ->

      @fs.copyTpl(
        @templatePath('_package.json'),
        @destinationPath('package.json'),
        { title: 'Templating with Yeoman' }
      )


    gulpFile : ->

      @fs.copy @templatePath('_gulpfile.coffee'), @destinationPath('gulpfile.coffee')


  install : ->

    @installDependencies()


  end : ->



