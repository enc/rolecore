class Relation < ActiveRecord::Base

  belongs_to :child, :polymorphic => true
  belongs_to :parent, :class_name => :role
  has_many :relation_propertiess
end
