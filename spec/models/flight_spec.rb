require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it { should validate_presence_of :number }
    it { should validate_presence_of :date }
    it { should validate_presence_of :time }
    it { should validate_presence_of :departure_city }
    it { should validate_presence_of :arrival_city }
  end

  describe 'relationships' do
    it { should belong_to :airline}
    it { should have_many :passenger_flights }
    it { should have_many(:passengers).through(:passenger_flights) }
  end

  describe 'method' do
    describe 'class methods' do
      before(:each) do
        @southwest = Airline.create(name: "Southwest")

        @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
        @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
        @southwest_3 = @southwest.flights.create(number: "SW3", date: "12/10/19", time: "1500", departure_city: "Denver", arrival_city: "Indianapolis")

        @passenger_1 = Passenger.create(name: 'Daniel Frampton', age: '45')
        @passenger_2 = Passenger.create(name: 'Jamie Frampton', age: '42')
        @passenger_3 = Passenger.create(name: 'Evalyn Frampton', age: '10')
        @passenger_4 = Passenger.create(name: 'Denison Frampton', age: '8')
        @passenger_5 = Passenger.create(name: 'Elodie Frampton', age: '5')
        @passenger_6 = Passenger.create(name: 'Henley Frampton', age: '4')

        @southwest_1.passengers << [@passenger_1, @passenger_3, @passenger_4]
        @southwest_2.passengers << [@passenger_2, @passenger_6, @passenger_5]
        @southwest_3.passengers << [@passenger_1, @passenger_2, @passenger_3, @passenger_4, @passenger_6, @passenger_5]
      end

      describe 'total_adult_passengers' do
        it 'returns total number of passengers 18 or older in age' do
          expect(@southwest_1.total_adult_passengers).to eq(1)
          expect(@southwest_2.total_adult_passengers).to eq(1)
          expect(@southwest_3.total_adult_passengers).to eq(2)
        end
      end

      describe 'total_minor_passengers' do
        it 'returns total number of passengers less than 18 years in age' do
          expect(@southwest_1.total_minor_passengers).to eq(2)
          expect(@southwest_2.total_minor_passengers).to eq(2)
          expect(@southwest_3.total_minor_passengers).to eq(4)
        end
      end
    end
  end
end
