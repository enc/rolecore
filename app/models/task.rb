class Task < ActiveRecord::Base
  attr_accessible :xOffset, :yOffset, :name

  has_many :relations, :as => :ancestor
  has_many :parents, :through => :relations
end
