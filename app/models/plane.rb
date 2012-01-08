class Plane
  def initialize
    roles = Role.all
    @x = 0
    @y = 0
    roles.each do |role|
      @x = role.xOffset if @x < role.xOffset
    end
    roles.each do |role|
      @y = role.yOffset if @y < role.yOffset
    end
  end
end
