module.exports = class <%= prefabClassName %> extends Phaser.Button

  constructor : (game, x, y) ->

    super game, x, y, '<%= prefabSpriteKey %>', @actionOnClick


  update : ->


  actionOnClick : ->
