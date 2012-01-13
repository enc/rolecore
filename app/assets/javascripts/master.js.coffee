global = exports ? this

Raphael.fn.connection = `function (obj1, obj2, line, bg) {
    if (obj1.line && obj1.from && obj1.to) {
        line = obj1;
        obj1 = line.from;
        obj2 = line.to;
    }
    var bb1 = obj1.getBBox(),
        bb2 = obj2.getBBox(),
        p = [ {x: bb1.x + bb1.width / 2, y: bb1.y + bb1.height + 1},
             {x: bb2.x + bb2.width / 2, y: bb2.y - 1} ],
        d = {}, dis = [];
    for (var i = 0; i < 1; i++) {
        for (var j = 1; j < 2; j++) {
            var dx = Math.abs(p[i].x - p[j].x),
                dy = Math.abs(p[i].y - p[j].y);
            if ((i == j - 1) || (((i != 0 && j != 2) || p[i].y > p[j].y) && ((i != 1 && j != 2) || p[i].y < p[j].y))) {
                dis.push(dx + dy);
                d[dis[dis.length - 1]] = [i, j];
            }
        }
    }
    var res = [0, 1];
    var x1 = p[res[0]].x,
        y1 = p[res[0]].y,
        x4 = p[res[1]].x,
        y4 = p[res[1]].y;
    dx = Math.max(Math.abs(x1 - x4) / 2, 10);
    dy = Math.max(Math.abs(y1 - y4) / 2, 10);
    var x2 = [x1][res[0]].toFixed(3),
        y2 = [y1 + dy][res[0]].toFixed(3),
        x3 = [0, x4 ][res[1]].toFixed(3),
        y3 = [0, y1 + dy][res[1]].toFixed(3);
    var path = ["M", x1.toFixed(3), y1.toFixed(3), "C", x2, y2, x3, y3, x4.toFixed(3), y4.toFixed(3)].join(",");
    if (line && line.line) {
        line.bg && line.bg.attr({path: path});
        line.line.attr({path: path});
    } else {
        var color = typeof line == "string" ? line : "#000";
        return {
            bg: bg && bg.split && this.path(path).attr({stroke: bg.split("|")[0], fill: "none", "stroke-width": bg.split("|")[1] || 3}),
            line: this.path(path).attr({stroke: color, fill: "none"}),
            from: obj1,
            to: obj2
        };
    }
};`

createForm = (form, paper) ->
  if typeof form == "string"
    is_path = true
    object = paper.path form
  else
    is_path = false
    object = form

  object.adjust = (dx,dy) ->
      object.translate dx * 2, dy * 2

  object.move = (dx,dy,factor) ->
    osize = factor if factor?
    osize ||= 1
    if is_path
      osize = 2
    osize = osize * (0.5 / object.factor)
    object.translate dx * osize, dy * osize

  object.size = (factor) ->
    object.scale factor, factor, 0, 0
    object.factor = factor

  object.changeColour = (colour) ->
    @attr
      fill: colour

  return object

createTask = (task) ->

  baseFrame = "M129-21.5H77.5V-73l0.5,0.5h-194.5c-6.627,0-13,4.373-13,11v122 c0,6.627,6.373,13,13,13h234c6.627,0,11-6.373,11-13V-22"
  signalEdge = "M129-21.5H77.5V-73l0.5,0.5h39.5c6.627,0,11,4.373,11,11V-22"
  clearFrame = "M129.5,60.862c0,6.979-5.469,12.638-12.216,12.638h-234.567,c-6.747,0-12.216-5.658-12.216-12.638V-60.862c0-6.979,5.469-12.638,12.216-12.638h234.567c6.747,0,12.216,5.658,12.216,12.638,V60.862z"
  plus =" M4.403-1H1v-3.173C1-4.63,0.463-5,0.006-5h-0.013C-0.463-5-1-4.63-1-4.173V-1h-3.403C-4.732-1-5-0.472-5-0.027,v0.054C-5,0.472-4.732,1-4.403,1H-1v3.173C-1,4.63-0.463,5-0.006,5h0.013C0.463,5,1,4.63,1,4.173V1h3.403C4.732,1,5,0.472,5,0.027,v-0.054C5-0.472,4.732-1,4.403-1z"
  cons = []
  task.scale = 0.6

  return {
    add_conn: (con) ->
      cons.push con

    id: ->
      return task.id

    draw: (@paper) ->
      unless task.xOffset?
        task.xOffset = 0
      unless task.yOffset?
        task.yOffset = 0

      @base = createForm clearFrame, @paper
      @base.adjust task.xOffset, task.yOffset
      @base.size task.scale
      @base.drag @move, @mreset, @update, @, @, @
      @base.attr
        fill: "rgb(11, 121, 224)"
        opacity: 0.8



      # @plus = createForm plus, @paper
      # @plus.adjust task.xOffset+(-52*task.scale), task.yOffset+(26*task.scale)
      # @plus.changeColour "rgb(0, 0, 0)"
      # @plus.size task.scale * 2
      # @plus.toFront()
      # @plus.click ->
        # $.ajax
          # url: 'relations/new'
          # dataType: 'script'
          # data:
            # task:
              # child_task_id: task.id

      # @label = createForm @paper.text(role.xOffset+(-90*role.scale), role.yOffset+(-55*role.scale), role.name), @paper
      @label = createForm @paper.text(0,0 , task.name), @paper
      @label.adjust task.xOffset+(-60*task.scale)+(@label.getBBox().width*0.4*task.scale), task.yOffset+(-23*task.scale)
      @label.attr
        'font-size': 18*task.scale
      @label.changeColour "rgb(0,0,0)"
      # label.translate xOffset, yOffset

    mreset: ->
      @x = 0
      @y = 0
      @xl = @label.attr("x")
      @yl = @label.attr("y")

    update: () ->
      task.xOffset += @x/2
      task.yOffset += @y/2
      $.ajax
        url: "tasks/#{task.id}"
        dataType: 'json'
        data: {task: task}
        type: "PUT"

    move: (dx, dy) ->
      @base.move (dx - @x), (dy - @y)
      @label.move (dx - @x), (dy - @y)
      # @plus.move (dx - @x), (dy - @y),1
      @x = dx
      @y = dy
      # $.each cons, (index,connection) ->
        # connection.refresh()

    refresh: ->
      jQuery.getJSON "tasks/#{task.id}", (data) ->
        task = data

    position: (x,y,event) ->
      if x? and y?
        @move x,y
      else
        [@x,@y]
  }
createRole = (role) ->

  baseFrame = "M129-21.5H77.5V-73l0.5,0.5h-194.5c-6.627,0-13,4.373-13,11v122 c0,6.627,6.373,13,13,13h234c6.627,0,11-6.373,11-13V-22"
  signalEdge = "M129-21.5H77.5V-73l0.5,0.5h39.5c6.627,0,11,4.373,11,11V-22"
  clearFrame = "M129.5,60.862c0,6.979-5.469,12.638-12.216,12.638h-234.567,c-6.747,0-12.216-5.658-12.216-12.638V-60.862c0-6.979,5.469-12.638,12.216-12.638h234.567c6.747,0,12.216,5.658,12.216,12.638,V60.862z"
  plus =" M4.403-1H1v-3.173C1-4.63,0.463-5,0.006-5h-0.013C-0.463-5-1-4.63-1-4.173V-1h-3.403C-4.732-1-5-0.472-5-0.027,v0.054C-5,0.472-4.732,1-4.403,1H-1v3.173C-1,4.63-0.463,5-0.006,5h0.013C0.463,5,1,4.63,1,4.173V1h3.403C4.732,1,5,0.472,5,0.027,v-0.054C5-0.472,4.732-1,4.403-1z"
  cons = []

  return {
    add_conn: (con) ->
      cons.push con

    id: ->
      return role.id

    draw: (@paper) ->
      unless role.xOffset?
        role.xOffset = 0
      unless role.yOffset?
        role.yOffset = 0
      role.scale = 0.5

      @base = createForm baseFrame, @paper
      @base.adjust role.xOffset, role.yOffset
      @base.size role.scale
      @base.drag @move, @mreset, @update, @, @, @
      @base.attr
        fill: "rgb(232, 224, 156)"
        opacity: 0.5


      @edge = createForm signalEdge, @paper
      @edge.adjust role.xOffset, role.yOffset
      if role.score > 3
        @edge.changeColour "rgb(255, 47, 0)"
      else
        if role.score == 0
          @edge.changeColour "rgb(75, 203, 11)"
        else
          @edge.changeColour "rgb(203, 175, 11)"


      @edge.size role.scale

      @aplus = createForm plus, @paper
      @aplus.adjust role.xOffset, role.yOffset+(-28*role.scale)
      @aplus.changeColour "rgb(0, 0, 0)"
      @aplus.size role.scale * 2
      @aplus.toFront()
      @aplus.click ->
        $.ajax
          url: 'relations/new'
          dataType: 'script'
          data:
            role:
              child_role_id: role.id

      @plus = createForm plus, @paper
      @plus.adjust role.xOffset+(-52*role.scale), role.yOffset+(26*role.scale)
      @plus.changeColour "rgb(0, 0, 0)"
      @plus.size role.scale * 2
      @plus.toFront()
      @plus.click ->
        $.ajax
          url: 'relations/new'
          dataType: 'script'
          data:
            role:
              parent_id: role.id

      # @label = createForm @paper.text(role.xOffset+(-90*role.scale), role.yOffset+(-55*role.scale), role.name), @paper
      @label = createForm @paper.text(0,0 , role.name), @paper
      @label.adjust role.xOffset+(-60*role.scale)+(@label.getBBox().width*0.4*role.scale), role.yOffset+(-23*role.scale)
      @label.size role.size
      @label.attr
        'font-size': 18*role.scale
      @label.changeColour "rgb(0,0,0)"
      # label.translate xOffset, yOffset

    mreset: ->
      @x = 0
      @y = 0
      @xl = @label.attr("x")
      @yl = @label.attr("y")

    update: () ->
      role.xOffset += @x/2
      role.yOffset += @y/2
      $.ajax
        url: "roles/#{role.id}"
        dataType: 'json'
        data: {role: role}
        type: "PUT"

    move: (dx, dy) ->
      @base.move (dx - @x), (dy - @y)
      @edge.move (dx - @x), (dy - @y)
      @label.move (dx - @x), (dy - @y)
      @aplus.move (dx - @x), (dy - @y),1
      @plus.move (dx - @x), (dy - @y),1
      @x = dx
      @y = dy
      $.each cons, (index,connection) ->
        connection.refresh()

    refresh: ->
      jQuery.getJSON "roles/#{role.id}", (data) ->
        role = data

    position: (x,y,event) ->
      if x? and y?
        @move x,y
      else
        [@x,@y]
  }

class PlaneManager
  constructor: (@plane) ->
    @x = window.innerWidth-16
    @y = window.innerHeight-92
    @scale = 1.0
    @paper = Raphael @plane, @x, @y
    @connections = []
    @roles = {}
    @tasks = {}
    global.planemanager = this
    $('#plane').width(@x).height(@y)
    $(window).resize ->
      $('#plane').width(window.innerWidth-16).height(window.innerHeight-92)


  freespace: ->
    [100, 200]

  add_task: (item) ->
    @tasks[item.id()] = item
    item.draw @paper

  add_role: (item) ->
    @roles[item.id()] = item
    item.draw @paper

  add_connection: (item) ->
    @connections.push item

  drawtasks: (tasks) ->
    pm = @
    if @paper?
      $.each tasks, (index, task) ->
        pm.add_task createTask(task)

  drawroles: (roles) ->
    pm = @
    if @paper?
      $.each roles, (index, role) ->
        pm.add_role createRole(role)

  drawconns: (conns) ->
    pm = @
    if @paper?
      $.each conns, (index, conn) ->
        pm.add_connection new Connection pm.roles[conn.parent_id], pm.roles[conn.child_role_id], pm.paper

  draw_connection: (pid, cid) ->
    pm = @
    pm.add_connection new Connection pm.roles[pid], pm.roles[cid], pm.paper

  move: (direction) ->
    content = $('#plane svg')
    @mt ||= parseInt(content.css('margin-top'))
    @ml ||= parseInt(content.css('margin-left'))
    switch direction
      when "up" then @mt -= 50
      when "down" then @mt += 50
      when "left" then @ml -= 50
      when "right" then @ml += 50
    content.css('margin-top', @mt)
    content.css('margin-left', @ml)

  enlarge: ->
    @scale -= 0.1
    @resize()

  shrink: ->
    @scale += 0.1
    @resize()

  resize: ->
    $('#plane svg').css('height', @x*@scale).css('width', @y * @scale)
    @paper.setViewBox(0,0, @x * @scale, @y * @scale)


class Connection
  constructor: (@parent, @child, @plane) ->
    if @child?
      @con = @plane.connection @parent.base, @child.base, "#000"
      @parent.add_conn @
      @child.add_conn @
    else
      console.log planemanager.roles

  refresh: ->
    @plane.connection @con



window.redraw = ->
  $('#plane').empty()
  pm = new PlaneManager('plane')
  jQuery.getJSON 'roles', (data) ->
    pm.drawroles(data)
    jQuery.getJSON 'tasks', (data) ->
      pm.drawtasks(data)
    jQuery.getJSON 'relations', (data) ->
      pm.drawconns(data)

$ ->
  # standart callbacks
  $("#create").click ->
    $("#roleform").show()

  redraw()
