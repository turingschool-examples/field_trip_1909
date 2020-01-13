require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
  end

  describe 'relationships' do
    it { should have_many :flight_passengers }
    it { should have_many(:flights).through(:flight_passengers) }
  end

  describe "minors class method" do
    it "can calculate the number of passengers under 18" do
      southwest = Airline.create(name: "Southwest")
      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      ralph = Passenger.create(name: "Ralph Ralpherson", age: 10)
      don = Passenger.create(name: "Don Donaldson", age: 31)
      john = Passenger.create(name: "John Johnson", age: 50)
      rando = Passenger.create(name: "Rando Randerson", age: 5)
      harris = Passenger.create(name: "Harris Harrison", age:15)

      southwest_1.passengers << [ralph, don, john, rando, harris]

      expect(southwest_1.passengers.minors).to eq(3)
    end
  end
end
