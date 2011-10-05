class Task < ActiveRecord::Base
  has_many :relations
  has_many :parents, :through => :relations
end
