# generator-phaser-coffeescript-gulp

> [Yeoman](http://yeoman.io) generator


## Getting Started

### What is Yeoman?

Trick question. It's not a thing. It's this guy:

![](http://i.imgur.com/JHaAlBJ.png)

Basically, he wears a top hat, lives in your computer, and waits for you to tell him what kind of application you wish to create.

Not every new computer comes with a Yeoman pre-installed. He lives in the [npm](https://npmjs.org) package repository. You only have to ask for him once, then he packs up and moves into your hard drive. *Make sure you clean up, he likes new and shiny things.*


### Installation

##### Install Yeoman and Gulp

```bash
npm i -g yo gulp
```

##### Install phaser-coffeescript-gulp generator


```bash
npm i -g generator-phaser-coffeescript-gulp
```

##### Initiate generator in a directory

```bash
mkdir my-game
cd $_
yo phaser-coffeescript-gulp
```

### Built-in web server with live-reload support

Once the generator is initiated you are ready to run `gulp` command.
Gulp will start a web server with live-reload support using [Browser-Sync](https://github.com/Browsersync/browser-sync), compile and merge coffee files.

![Gulp Demo](http://g.recordit.co/AmblNXxmN0.gif)

And you are ready to start developing awesome games right away!

### Prefab Generator

To generate a prefab run `yo phaser-coffeescript-gulp:prefab prefabname`. You will see the prefab choices:

![Prefab Demo](http://g.recordit.co/Yt7g7tG52m.gif)

Then you can require your newly generated prefab in a state file.

### State Generator

To generate a state run `yo phaser-coffeescript-gulp:state statename`.

![State Demo](http://g.recordit.co/YmGLbBKSUO.gif)

## License

MIT
