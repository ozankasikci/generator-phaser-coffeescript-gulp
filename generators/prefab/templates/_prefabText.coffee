module.exports = class <%= prefabClassName %> extends Phaser.Text

  constructor : (game, x, y, text, style = {}) ->

    super game, x, y, text, style
    @game.add.existing this


  update : ->
