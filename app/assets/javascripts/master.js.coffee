# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


class Role
  constructor: (@role) ->
    @baseFrame = "M129-21.5H77.5V-73l0.5,0.5h-194.5c-6.627,0-13,4.373-13,11v122 c0,6.627,6.373,13,13,13h234c6.627,0,11-6.373,11-13V-22"
    @signalEdge = "M129-21.5H77.5V-73l0.5,0.5h39.5c6.627,0,11,4.373,11,11V-22"


  draw: (@paper) ->
    unless @role.xOffset?
      @role.xOffset = 0
    unless @role.yOffset?
      @role.yOffset = 0
    @role.scale = 0.5

    @base = @paper.path(@baseFrame)
    @base.translate @role.xOffset, @role.yOffset
    @base.attr
      fill: "rgb(232, 224, 156)"
      opacity: 0.5
    @base.scale @role.scale, @role.scale, 0, 0
    @base.drag @move, @mreset, null, @

    @edge = @paper.path @signalEdge
    @edge.translate @role.xOffset, @role.yOffset
    @edge.attr
      fill: "rgb(255, 47, 0)"
    @edge.scale @role.scale, @role.scale, 0, 0

    @label = @paper.text @role.xOffset+(-90*@role.scale), @role.yOffset+(-55*@role.scale), @role.name
    @label.attr
      'font-size': 18*@role.scale
    # label.translate xOffset, yOffset

  mreset: ->
    console.log("Path attr #{@base.attr "x"}")
    @x = 0
    @y = 0
    @xl = @label.attr("x")
    @yl = @label.attr("y")

  move: (dx, dy) ->
    @base.translate (dx - @x)*2, (dy - @y)*2
    @edge.translate (dx - @x)*2, (dy - @y)*2
    @label.translate (dx - @x), (dy - @y)
    @x = dx
    @y = dy

  position: (x,y,event) ->
    if x? and y?
      @move x,y
    else
      [@x,@y]

class PlaneManager
  constructor: (@plane) ->
    @paper = Raphael @plane, window.innerWidth-16, window.innerHeight-92

  freespace: ->
    [100, 200]

  add_object: (item) ->
    item.draw @paper

drawroles = (roles) ->
  $('#plane').empty()
  paper = new PlaneManager('plane')
  $.each roles, (index, role) ->
    paper.add_object new Role(role)

window.redraw = ->
  jQuery.getJSON 'roles', (data) ->
    drawroles(data)

$ ->
  # standart callbacks
  $("#create").click ->
    $("#roleform").show()

  redraw()
