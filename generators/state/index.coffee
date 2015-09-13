_s          = require 'underscore.string'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'

module.exports = generators.NamedBase.extend

  initializing : ->

    @log yosay chalk.green "Creating a new state, hang tight!"
    @name           = @name.replace '.coffee', ''
    @stateClassName = _s.classify @name


  prompting : ->


  writing :

    app : ->

      @fs.copyTpl(
        @templatePath('_state.coffee'), @destinationPath("app/scripts/states/#{@name}.coffee"),
        { stateClassName : @stateClassName }
      )


  end : ->

    @log chalk.yellow("File name is: #{@name}.coffee")
    @log chalk.yellow("Class name is: #{@stateClassName}")
    @log chalk.green('Created a new state successfully!')


