class PassengersController < ApplicationController
  def show
    @passager = Passenger.find(params[:id])
  end
end
