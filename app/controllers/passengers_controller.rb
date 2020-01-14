class PassengersController < ApplicationController
  def remove
    flights = Flight.find(params[:flight_id])
    pass = flights.passengers.find(params[:passanger_id])
    pass.passenger_flights[0].destroy
    redirect_to '/flights'
  end
  def index
    @passangers = Passenger.all
  end
end
