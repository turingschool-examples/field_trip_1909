class BookingsController < ApplicationController
  def create 
    passenger = Passenger.find_by(id: params[:passenger_id])
    flight = Flight.find_by(number: params[:flight_number])
    if (flight)
      flight.passengers << passenger 
      redirect_to "/passengers/#{passenger.id}"
    end
  end
end