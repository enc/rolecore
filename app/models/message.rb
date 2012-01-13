class Message < ActiveRecord::Base
  has_many :badges
  has_many :roles, :through => :badges
end
