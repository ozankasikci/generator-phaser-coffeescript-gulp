module.exports = class <%= prefabClassName %> extends Phaser.Sprite

  constructor : (game, x, y, frame = null) ->

    super game, x, y, '<%= prefabSpriteKey %>', frame
    @game.add.existing this


  update : ->
