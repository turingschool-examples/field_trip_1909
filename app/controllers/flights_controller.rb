class FlightsController < ApplicationController
  def show
    @flight = Flight.find_by(id: params[:id])
  end
end