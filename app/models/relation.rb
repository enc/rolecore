class Relation < ActiveRecord::Base
  has_many :relation_properties
  belongs_to :parent, :class_name => "Role"
  belongs_to :child_role, :class_name => "Role"
  belongs_to :child_task, :class_name => "Task"

  after_save :check_roles
  def check_roles
    Checker.check_all
  end

  def linked
    return @objects if @objects
    @objects = Array.new
    if child_role
      @objects.push child_role.all_childs
      @objects.push child_role.all_uppers
    end
    if parent
      @objects.push parent.all_childs
      @objects.push parent.all_uppers
    end
    @objects = @objects.flatten.uniq.delete_if {|item| [parent,child_role, child_task].include? item }
  end
  def t_linked
    return @tobjects if @tobjects
    @tobjects = Array.new
    if parent
      @tobjects.push parent.all_tasks
    end
    @tobjects = @tobjects.flatten.uniq.delete_if {|item| [parent,child_role, child_task].include? item }
  end
end
