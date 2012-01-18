class Plane
  def initialize
    roles = Role.all
    tasks = Task.all
    @x = 0
    @y = 0
    roles.each do |role|
      @x = role.xOffset if @x < role.xOffset
    end
    roles.each do |role|
      @y = role.yOffset if @y < role.yOffset
    end
    tasks.each do |task|
      @x = task.xOffset if @x < task.xOffset
    end
    tasks.each do |task|
      @y = task.yOffset if @y < task.yOffset
    end
    @x = @x * 2 + 150
    @y = @y * 2 + 100
  end
end
