class Menu

  create : ->

    console.log 'menu'
    @backgroundColor = 0xFFFFFF
    @game.state.start 'main'


module.exports = Menu
