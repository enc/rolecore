class Relation < ActiveRecord::Base
  has_many :relation_properties
  belongs_to :parent, :class_name => "Role"
  belongs_to :child_role, :class_name => "Role"
  belongs_to :child_task, :class_name => "Task"

  def linked
    return @objects if @objects
    @objects = Array.new
    if child_role
      @objects.push child_role.childs
      @objects.push child_role.uppers
    end
    if parent
      @objects.push parent.childs
      @objects.push parent.uppers
    end
    @objects.flatten.uniq
  end
end
