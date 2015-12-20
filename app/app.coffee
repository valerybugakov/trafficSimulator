'use strict'

require './helpers'
$ = require 'jquery'
_ = require 'underscore'
Visualizer = require './visualizer/visualizer'
DAT = require 'dat-gui'
World = require './model/world'
settings = require './settings'

$ ->
  canvas = $('<canvas />', {id: 'canvas'})
  $(document.body).append(canvas)

  window.world = new World()
  world.load()
  # if world.intersections.length is 0
    # world.generateMap()
    # world.carsNumber = 100

  window.visualizer = new Visualizer world
  visualizer.start()
  router =
    help: -> window.location = window.location.pathname.replace(/[^/]*$/, 'help.html')

  # Control menu
  gui = new DAT.GUI()
  guiWorld = gui.addFolder 'УДС'
  guiWorld.open()
  guiWorld.add(world, 'save').name 'Сохранить'
  guiWorld.add(world, 'load').name 'Загрузить'
  guiWorld.add(world, 'clear').name 'Очистить'
  guiWorld.add(world, 'generateMap').name 'Сгенерировать'
  guiWorld.add(router, 'help').name 'Справка'
  guiWorld.add(world, 'carsNumber').min(0).max(200).step(1).name('Количество машин').listen()
  # guiWorld.add(world, 'instantSpeed').step(0.00001).listen()
  guiVisualizer = gui.addFolder 'Визуализатор'
  guiVisualizer.open()
  guiVisualizer.add(visualizer, 'running').listen()
  guiVisualizer.add(visualizer, 'debug').listen()
  guiVisualizer.add(visualizer.zoomer, 'scale', 0.1, 2).name('Масштаб').listen()
  guiVisualizer.add(visualizer, 'timeFactor', 0.1, 10).name('Модельное время').listen()
  # gui.add(settings, 'lightsFlipInterval', 0, 400, 0.01).listen()
