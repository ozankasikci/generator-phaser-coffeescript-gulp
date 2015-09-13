_s          = require 'underscore.string'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'

module.exports = generators.NamedBase.extend

  initializing : ->

    @log yosay chalk.green "Creating a new prefab, hang tight!"
    @name = @name.replace '.coffee', ''


  prompting : ->

    prefabTypesWithSpriteKey = ['Sprite', 'TileSprite', 'Emitter', 'Button']

    done = @async()

    @prompt [
      {
        type    : 'list'
        name    : 'prefabType'
        message : 'What type of prefab would you like to create?'
        choices : ['Sprite', 'TileSprite', 'Group', 'Text', 'Button', 'Emitter', 'BitmapData']
        default : 0
      }
      {
        when     : (props) -> props.prefabType in prefabTypesWithSpriteKey
        type     : 'input'
        name     : 'prefabSpriteKey'
        message  : "What is your prefab's sprite key?"
        validate : (input) ->
          return 'You must enter a sprite key' unless input
          return true
      }
    ], (props) =>
      @props                 = props
      @props.prefabClassName = _s.classify @name
      @props.prefabSpriteKey = _s.slugify props.prefabSpriteKey
      done()


  writing :

    app : ->

      templates =
        'Text'       : '_prefabText.coffee'
        'Group'      : '_prefabGroup.coffee'
        'Button'     : '_prefabButton.coffee'
        'Sprite'     : '_prefabSprite.coffee'
        'Emitter'    : '_prefabEmitter.coffee'
        'TileSprite' : '_prefabTileSprite.coffee'
        'BitmapData' : '_prefabBitmapData.coffee'

      @fs.copyTpl(
        @templatePath(templates[@props.prefabType]), @destinationPath("app/scripts/prefabs/#{@name}.coffee"),
        { prefabSpriteKey : @props.prefabSpriteKey, prefabClassName : @props.prefabClassName }
      )


  end : ->

    @log chalk.yellow("File name is: #{@name}.coffee")
    @log chalk.yellow("Class name is: #{@props.prefabClassName}")
    @log chalk.green('Created a new prefab successfully!')


