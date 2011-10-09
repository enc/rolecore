class Task < ActiveRecord::Base
  has_many :relations, :as => :ancestor
  has_many :parents, :through => :relations
end
