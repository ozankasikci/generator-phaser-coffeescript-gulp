_s          = require 'underscore.string'
chalk       = require 'chalk'
yosay       = require 'yosay'
generators  = require 'yeoman-generator'

module.exports = generators.NamedBase.extend

  initializing : ->

    @log yosay chalk.green "Creating a new prefab, hang tight!"
    @name = @name.replace '.coffee', ''


  prompting : ->

    spriteKeyRequired       = no
    prefabTypesWithSpriteKey = ['Sprite', 'TileSprite', 'Emitter']

    done = @async()

    @prompt [
      {
        type: 'list'
        name: 'prefabType'
        message: 'What type of prefab would you like to create?'
        choices : ['Sprite', 'TileSprite', 'Group', 'Text', 'Emitter', 'BitmapData']
        default : 0
      }
    ], (props) =>
      @props                 = props
      @prefabType            = props.prefabType
      @props.prefabClassName = _s.classify @name

      # return if we don't need a sprite key in prefab
      return done()  unless @spriteKeyRequired = @prefabType in prefabTypesWithSpriteKey

      # prompt again for sprite key
      @prompt [
        {
          type: 'input'
          name: 'prefabSpriteKey'
          message: "What is your prefab's sprite key?"
          validate : (input) ->
            return 'You must enter a sprite key' unless input
            return true
        }
      ], (props) =>
        @props.prefabSpriteKey = _s.slugify props.prefabSpriteKey
        done()


  writing :

    app : ->

      templates =
        'Text'       : '_prefabText.coffee'
        'Group'      : '_prefabGroup.coffee'
        'Sprite'     : '_prefabSprite.coffee'
        'Emitter'    : '_prefabEmitter.coffee'
        'TileSprite' : '_prefabTileSprite.coffee'
        'BitmapData' : '_prefabBitmapData.coffee'

      @fs.copyTpl(
        @templatePath(templates[@prefabType]), @destinationPath("app/prefab/#{@name}.coffee"),
        { prefabSpriteKey : @props.prefabSpriteKey, prefabClassName : @props.prefabClassName }
      )


  end : ->

    @log chalk.yellow("File name is: #{@name}.coffee")
    @log chalk.yellow("Class name is: #{@props.prefabClassName}")
    @log chalk.green('Created a new prefab successfully!')


