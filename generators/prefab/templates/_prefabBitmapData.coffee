module.exports = class <%= prefabClassName %> extends Phaser.BitmapData

  constructor : (game, width, height, key = '') ->

    key = game.rnd.uuid() unless key
    super game, key, width, height


  update : ->
