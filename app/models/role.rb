class Role < ActiveRecord::Base

  has_many :relations, :foreign_key => :parent_id
  has_many :upper_relations, :class_name => "Relation", :foreign_key => :child_role_id
  has_many :upers, :through => :upper_relations, :source => :parent
  has_many :childs, :through => :relations, :source => :child_role
  has_many :tasks, :through => :relations, :source => :child_task


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
    tasks + childs.collect { |i| i.all_tasks } .flatten
  end
end
