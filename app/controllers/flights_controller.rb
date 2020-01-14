class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end
  # def remove
  #   flights = Flight.find(params[:flight_id])
  #   pass = flights.passengers.find(params[:passanger_id])
  #   binding.pry
  #   pass.destroy
  # end
end
