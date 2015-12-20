'use strict'

{min, max} = Math
require '../helpers.coffee'
$ = require 'jquery'
_ = require 'underscore'
Point = require '../geom/point.coffee'
Rect = require '../geom/rect.coffee'
require('jquery-mousewheel')

METHODS = [
  'click'
  'mousedown'
  'mouseup'
  'mousemove'
  'mouseout'
  'mousewheel'
  'contextmenu'
]

class Tool
  constructor: (@visualizer, autobind) ->
    @ctx = @visualizer.ctx
    @canvas = @ctx.canvas
    @isBound = false
    @bind() if autobind

  bind: ->
    @isBound = true
    for method in METHODS when @[method]?
      $(@canvas).on method, @[method]

  unbind: ->
    @isBound = false
    for method in METHODS when @[method]?
      $(@canvas).off method, @[method]

  toggleState: ->
    if @isBound then @unbind() else @bind()

  draw: ->

  getPoint: (e) ->
    new Point e.pageX - @canvas.offsetLeft, e.pageY - @canvas.offsetTop

  getCell: (e) ->
    @visualizer.zoomer.toCellCoords @getPoint(e), e

  getHoveredIntersection: (cell) ->
    intersections = @visualizer.world.intersections.all()
    for id, intersection of intersections
      return intersection if intersection.rect.containsRect cell

  getHoveredRoadSegment: (cell) ->
    roads = @visualizer.world.roads.all()
    for id, road of roads

      if road.targetSideId == 0 and road.sourceSideId == 2 ||
         road.targetSideId == 1 and road.sourceSideId == 3
        sourceC = road.sourceSide.target
        targetC = road.targetSide.source

      if road.targetSideId == 2 and road.sourceSideId == 0 ||
         road.targetSideId == 3 and road.sourceSideId == 1
        sourceC = road.sourceSide.source
        targetC = road.targetSide.target

      type = if road.targetSideId in [1,3] then 'hor' else 'vert'

      x0 = sourceC.x
      y0 = sourceC.y

      x = targetC.x
      y = targetC.y

      dx = cell.x
      dy = cell.y
      buildingPoint = new Point cell.center().x, cell.center().y

      zn1 = x - x0
      if (x - x0) * (dy - y0) - (dx - x0) * (y - y0) == 0
        if type == 'hor'
          left = min x0, x
          right = max x0, x

          if dx >= left && dx <= right
            buildingPoint.carSpawnPos = road.sourceSide.source.subtract(buildingPoint).length
            road.buildings.push buildingPoint
            return road

        if type == 'vert'
          bot = min y0, y
          top = max y0, y

          if dy >= bot && dy <= top
            buildingPoint.carSpawnPos = road.sourceSide.source.subtract(buildingPoint).length
            road.buildings.push buildingPoint
            return road

module.exports = Tool
