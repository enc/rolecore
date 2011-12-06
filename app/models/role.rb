class Role < ActiveRecord::Base

  attr_accessible :xOffset, :yOffset, :name, :weight

  has_many :relations, :foreign_key => :parent_id
  has_many :upper_relations, :class_name => "Relation", :foreign_key => :child_role_id
  has_many :upers, :through => :upper_relations, :source => :parent
  has_many :childs, :through => :relations, :source => :child_role
  has_many :tasks, :through => :relations, :source => :child_task


  def as_json
    super(:methods => :task_count)
  end
  def add_subrole role
    rel = Relation.create
    rel.child_role = role
    rel.save
    self.relations << rel
  end

  def add_task task
    self.tasks << task
  end

  def all_tasks
    tasks + childs.all.collect { |i| i.all_tasks } .flatten
  end

  def task_count
    all_tasks.count
  end

  def all_childs
    (childs.all + childs.all.collect { |i| i.all_childs } ).flatten
  end

  def subrole role
    o_tasks = all_tasks.collect { |i| i.id }
    r_tasks = role.all_tasks.collect { |i| i.id }
    return -1 if (o_tasks.select { |i| r_tasks.include? i }).empty?
    return 1 if (r_tasks.select { |i| o_tasks.include? i }).empty?
    return 0
  end
end
