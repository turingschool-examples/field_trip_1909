class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:id])
  end

  def create
    passenger = Passenger.find(params[:id])
    flight = Flight.where(flight_params).first

    passenger.flights << flight

    redirect_to "/passengers/#{params[:id]}"
  end

  private
    def flight_params
      params.permit(:number)
    end
end
