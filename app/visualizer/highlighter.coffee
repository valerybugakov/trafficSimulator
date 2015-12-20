'use strict'

require '../helpers.coffee'
Tool = require './tool.coffee'
settings = require '../settings.coffee'

class ToolHighlighter extends Tool
  constructor: ->
    super arguments...
    @hoveredCell = null

  mousemove: (e) =>
    cell = @getCell e
    if e.metaKey
      cell._width = 7
      cell._height = 7
    hoveredIntersection = @getHoveredIntersection cell
    @hoveredCell = cell
    for id, intersection of @visualizer.world.intersections.all()
      intersection.color = null
    if hoveredIntersection?
      hoveredIntersection.color = settings.colors.hoveredIntersection

  mouseout: =>
    @hoveredCell = null

  draw: =>
    if @hoveredCell
      color = settings.colors.hoveredGrid
      @visualizer.graphics.fillRect @hoveredCell, color, 0.5, { showCoords: true }

module.exports = ToolHighlighter
