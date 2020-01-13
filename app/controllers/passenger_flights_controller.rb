class PassengerFlightsController < ApplicationController
  def create
    passenger = Passenger.find(params[:id])
    passenger.flights << Flight.find_by(number: params[:number])
    redirect_to "/passengers/#{passenger.id}"
  end
end
