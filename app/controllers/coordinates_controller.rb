class CoordinatesController < ApplicationController
  before_action :find_coordinate, only: [:update]

  def update
    @coordinate.update(coordinates_params)
    render json: { success: true, coordinate: @coordinate }
  end

  private

  def coordinates_params
    params.require(:coordinate).permit(:latitude, :longitude, :location)
  end

  def find_coordinate
    @coordinate = Coordinate.find(params[:id])
  end

end
