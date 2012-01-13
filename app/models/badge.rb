class Badge < ActiveRecord::Base
  belongs_to :role
  belongs_to :message
end
