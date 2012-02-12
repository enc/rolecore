class Role < ActiveRecord::Base

  attr_accessible :xOffset, :yOffset, :name, :weight, :user_ids

  has_many :badges
  has_many :message, :through => :badges
  has_many :relations, :foreign_key => :parent_id
  has_many :upper_relations, :class_name => "Relation", :foreign_key => :child_role_id
  has_many :uppers, :through => :upper_relations, :source => :parent
  has_many :childs, :through => :relations, :source => :child_role
  has_many :tasks, :through => :relations, :source => :child_task
  has_many :memberships
  has_many :users, :through => :memberships

  after_save :check_roles
  def check_roles
    Checker.check_all
  end



  def as_json options
    super(:methods => [:task_count,:score,:task_count,:user_count])
  end

  def <=> comp
    self.id <=> comp.id
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

  def user_count
    users.count
  end

  def all_tasks
    tasks + childs.all.collect { |i| i.all_tasks } .flatten.uniq
  end

  def hight
    if childs.count > 0
      1 + childs.all.collect { |i| i.hight } .max
    else
      1
    end
  end

  def task_count
    all_tasks.uniq.count
  end

  def all_uppers
    (uppers.all + uppers.all.collect { |i| i.all_uppers } ).flatten
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

  def score
    value = 0
    badges.each { |badge| value += badge.score }
    return value
  end
end
