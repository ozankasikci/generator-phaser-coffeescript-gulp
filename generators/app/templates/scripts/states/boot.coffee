class Boot

  preload: ->
    @load.image 'preloader', 'assets/images/preloader.gif'

  create: ->
    @game.input.maxPointers = 1
    if @game.device.desktop
      @game.scale.pageAlignHorizontally = true
    else
      @game.scaleMode = Phaser.ScaleManager.SHOW_ALL
      @game.scale.minWidth = 480
      @game.scale.minHeight = 260
      @game.scale.maxWidth = 640
      @game.scale.maxHeight = 480
      @game.scale.forceLandscape = true
      @game.scale.setScreenSize true

    @game.state.start 'preloader'

module.exports = Boot