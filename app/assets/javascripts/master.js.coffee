# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


class Rolemodel
  constructor: (@paper) ->
    @baseFrame = "M129-21.5H77.5V-73l0.5,0.5h-194.5c-6.627,0-13,4.373-13,11v122 c0,6.627,6.373,13,13,13h234c6.627,0,11-6.373,11-13V-22"
    @signalEdge = "M129-21.5H77.5V-73l0.5,0.5h39.5c6.627,0,11,4.373,11,11V-22"


  draw: (xOffset, yOffset) ->
    c = @paper.path(@baseFrame)
    c.translate xOffset, yOffset
    c.attr
      fill: "rgb(232, 224, 156)"
      opacity: 0.5
    d = @paper.path @signalEdge
    d.translate xOffset, yOffset
    d.attr
      fill: "rgb(255, 47, 0)"

class Testor
  constructor: (@msg) ->

  hail: ->
    alert @msg + ":says the King."

jQuery ($) ->

  role = new Rolemodel Raphael("plane", 720, 400)
  role.draw(180,90)
