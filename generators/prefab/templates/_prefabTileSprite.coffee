module.exports = class <%= prefabClassName %> extends Phaser.TileSprite

  constructor : (game, x, y, width, height, frame = null) ->

    super game, x, y, width, height, '<%= prefabSpriteKey %>', frame
    @game.add.existing this


  update : ->
