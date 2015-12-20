'use strict'

require '../helpers'
_ = require 'underscore'
Rect = require '../geom/rect'

class Building
  constructor: (@rect) ->
    @id = _.uniqueId 'building'
    @road = null

  @copy: (building) ->
    building.rect = Rect.copy building.rect
    result = Object.create Building::
    _.extend result, building
    result.road = null
    result

  toJSON: ->
    obj =
      id: @id
      rect: @rect
      road: @road

  update: ->
    @road.update()

module.exports = Building

