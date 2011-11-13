class MasterController < ApplicationController
  def root
    @roles = Role.all
    @role = Role.new
  end

end
