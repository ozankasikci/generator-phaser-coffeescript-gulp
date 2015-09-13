module.exports = class <%= prefabClassName %> extends Phaser.Sprite

  constructor : (game, x, y, frame = null) ->

    super game, x, y, '<%= prefabSpriteKey %>', frame


  create : ->

    @game.add.existing this


  update : ->
