global = exports ? this

Raphael.fn.connection = `function (obj1, obj2, line, bg) {
    if (obj1.line && obj1.from && obj1.to) {
        line = obj1;
        obj1 = line.from;
        obj2 = line.to;
    }
    var bb1 = obj1.getBBox(),
        bb2 = obj2.getBBox(),
        p = [{x: bb1.x + bb1.width / 2, y: bb1.y - 1},
        {x: bb1.x + bb1.width / 2, y: bb1.y + bb1.height + 1},
        {x: bb2.x + bb2.width / 2, y: bb2.y - 1},
        {x: bb2.x + bb2.width / 2, y: bb2.y + bb2.height + 1}],
        d = {}, dis = [];
    for (var i = 0; i < 2; i++) {
        for (var j = 2; j < 4; j++) {
            var dx = Math.abs(p[i].x - p[j].x),
                dy = Math.abs(p[i].y - p[j].y);
            if ((i == j - 2) || (((i != 0 && j != 3) || p[i].y > p[j].y) && ((i != 1 && j != 2) || p[i].y < p[j].y))) {
                dis.push(dx + dy);
                d[dis[dis.length - 1]] = [i, j];
            }
        }
    }
    if (dis.length == 0) {
        var res = [0, 2];
    } else {
        res = d[Math.min.apply(Math, dis)];
    }
    var x1 = p[res[0]].x,
        y1 = p[res[0]].y,
        x4 = p[res[1]].x,
        y4 = p[res[1]].y;
    dx = Math.max(Math.abs(x1 - x4) / 2, 10);
    dy = Math.max(Math.abs(y1 - y4) / 2, 10);
    var x2 = [x1, x1][res[0]].toFixed(3),
        y2 = [y1 - dy, y1 + dy][res[0]].toFixed(3),
        x3 = [0, 0, x4, x4 ][res[1]].toFixed(3),
        y3 = [0, 0, y1 + dy, y1 - dy ][res[1]].toFixed(3);
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
class Role
  constructor: (@role) ->
    @baseFrame = "M129-21.5H77.5V-73l0.5,0.5h-194.5c-6.627,0-13,4.373-13,11v122 c0,6.627,6.373,13,13,13h234c6.627,0,11-6.373,11-13V-22"
    @signalEdge = "M129-21.5H77.5V-73l0.5,0.5h39.5c6.627,0,11,4.373,11,11V-22"
    @id = @role.id
    @cons = []


  add_conn: (con) ->
    @cons.push con

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
    @base.drag @move, @mreset, @update, @, @, @

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
    @x = 0
    @y = 0
    @xl = @label.attr("x")
    @yl = @label.attr("y")

  update: () ->
    @role.xOffset += @x
    @role.yOffset += @y
    $.ajax
      url: "roles/#{@role.id}"
      dataType: 'json'
      data: {role: @role}
      type: "PUT"



  move: (dx, dy) ->
    @base.translate (dx - @x)*2, (dy - @y)*2
    @edge.translate (dx - @x)*2, (dy - @y)*2
    @label.translate (dx - @x), (dy - @y)
    @x = dx
    @y = dy
    $.each @cons, (index,connection) ->
      connection.refresh()

  refresh: ->
    jQuery.getJSON "roles/#{@role.id}", (data) ->
      @role = data

  position: (x,y,event) ->
    if x? and y?
      @move x,y
    else
      [@x,@y]

class PlaneManager
  constructor: (@plane) ->
    @paper = Raphael @plane, window.innerWidth-16, window.innerHeight-92
    @connections = []
    @roles = {}
    global.planemanager = this

  freespace: ->
    [100, 200]

  add_role: (item) ->
    @roles[item.id] = item
    console.log item.id
    item.draw @paper

  add_connection: (item) ->
    console.log "Draw conn."
    @connections.push item

  drawroles: (roles) ->
    pm = @
    if @paper?
      $.each roles, (index, role) ->
        pm.add_role new Role(role)

  drawconns: (conns) ->
    pm = @
    if @paper?
      $.each conns, (index, conn) ->
        pm.add_connection new Connection pm.roles[conn.parent_id], pm.roles[conn.child_role_id], pm.paper

class Connection
  constructor: (@parent, @child, @plane) ->
    @con = @plane.connection @parent.base, @child.base, "#000"
    @parent.add_conn @
    @child.add_conn @

  refresh: ->
    @plane.connection @con



window.redraw = ->
  $('#plane').empty()
  pm = new PlaneManager('plane')
  jQuery.getJSON 'roles', (data) ->
    pm.drawroles(data)
    jQuery.getJSON 'relations', (data) ->
      console.log data
      pm.drawconns(data)

$ ->
  # standart callbacks
  $("#create").click ->
    $("#roleform").show()

  redraw()
