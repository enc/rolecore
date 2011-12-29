class User < ActiveRecord::Base
  has_many :memberships
  has_many :roles, :through => :memberships


  def info
    "Die tolle Rolle!!"
  end
end
