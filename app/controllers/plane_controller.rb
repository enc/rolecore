class PlaneController < ApplicationController
  def show
    pl = Plane.new
    respond_to do |format|
      format.json { render json: pl }
    end
  end

  def update
  end

end
