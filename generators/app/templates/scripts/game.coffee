Boot    = require './states/boot'
Preload = require './states/preload'
Menu    = require './states/menu'
Main    = require './states/main'

class Game extends Phaser.Game

  constructor : ->

    super(600, 480, Phaser.AUTO, 'game-content');

    @state.add('boot', Boot);
    @state.add('preload', Preload);
    @state.add('menu', Menu);
    @state.add('main', Main);

    @state.start('boot');


window.onload = ->

  game = new Game()