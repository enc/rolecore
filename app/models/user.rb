class User < ActiveRecord::Base
  has_many :memberships
  has_many :roles, :through => :memberships
end
