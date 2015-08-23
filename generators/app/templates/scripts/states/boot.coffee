class Boot

  preload: ->

    @game.load.image 'preloader', 'assets/images/preloader.gif'


  create: ->

    @game.stage.backgroundColor = 0x000000
    @scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    @game.state.start 'preload'


module.exports = Boot
