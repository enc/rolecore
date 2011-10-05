class Role < ActiveRecord::Base

  has_many :relations
  has_many :parents, :through => :relations
  has_many :childs, :through => :relations
end
