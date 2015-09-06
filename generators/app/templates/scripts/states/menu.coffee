class Menu

  create : ->

    @backgroundColor = 0xFFFFFF
    @game.state.start 'main'


module.exports = Menu
