module.exports = class <%= prefabClassName %> extends Phaser.Particles.Arcade.Emitter

  constructor : (game, x, y, maxParticles = 50) ->

    super game, x, y, maxParticles
    @makeParticles '<%= prefabSpriteKey %>'


  update : ->
