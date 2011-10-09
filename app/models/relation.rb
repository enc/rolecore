class Relation < ActiveRecord::Base
  has_many :relation_properties
  belongs_to :parent, :class_name => "Role"
  belongs_to :child_role, :class_name => "Role"
  belongs_to :child_task, :class_name => "Task"
end
