class Preload

  preload: ->

    loadingBar = @add.sprite 320, 240, 'preloader'
    loadingBar.anchor.setTo 0.5, 0.5
    @load.setPreloadSprite loadingBar

    @game.load.image 'starBackground','assets/backgrounds/starfield.jpg', 138, 15
    @game.load.image 'logo', 'assets/sprites/phaser2.png'


  create: ->

    @game.state.start 'menu'


module.exports = Preload
