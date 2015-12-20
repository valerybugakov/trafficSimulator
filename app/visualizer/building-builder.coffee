'use strict'

require '../helpers'
Tool = require './tool'
Building = require '../model/building' # TODO: decouple

class ToolBuildingBuilder extends Tool
  constructor: ->
    super arguments...
    @tempBuilding = null
    @mouseDownPos = null

  mousedown: (e) =>
    @mouseDownPos = @getCell e
    hoveredRoad= @getHoveredRoadSegment @mouseDownPos
    # hoveredRoad.buildings.push @mouseDownPos
    if hoveredRoad
      world.roadsWithBuilgings.push hoveredRoad
      console.log hoveredRoad
      if e.metaKey
        @tempBuilding = new Building @mouseDownPos
        e.stopImmediatePropagation()

  mouseup: =>
    if @tempBuilding
      @visualizer.world.addBuilding @tempBuilding
      @tempBuilding = null
    @mouseDownPos = null

  mousemove: (e) =>
    # hoveredRoadSegment = @getHoveredRoadSegment @mouseDownPos
    # if hoveredRoadSegment && @tempBuilding
    #   rect = @visualizer.zoomer.getBoundingBox @mouseDownPos, @getCell e
    #   @tempBuilding.rect = rect

    if @tempBuilding
      rect = @visualizer.zoomer.getBoundingBox @mouseDownPos, @getCell e
      @tempBuilding.rect = rect


  mouseout: =>
    @mouseDownPos = null
    @tempBuilding = null

  draw: =>
    if @tempBuilding
      @visualizer.drawBuilding @tempBuilding, 0.4

module.exports = ToolBuildingBuilder

