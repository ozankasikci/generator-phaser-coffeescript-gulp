module.exports = class <%= prefabClassName %> extends Phaser.Text

  constructor : (game, x, y, text, style = {}) ->

    super game, x, y, text, style


  crete : ->

    @game.add.existing this


  update : ->
