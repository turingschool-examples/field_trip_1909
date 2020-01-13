require 'rails_helper'

RSpec.describe Flight, type: :model do

  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many(:flight_passengers)}
    it {should have_many(:passengers).through(:flight_passengers)}
  end

  describe 'instance methods' do
    before {
      @airline_1 = Airline.create({
        name: "Southwest Airlines"
      })

      @flight_1 = Flight.create!({
        number: "511431",
        date: '2020-01-05',
        time: "12:30",
        departure_city: "Denver",
        arrival_city: "Detroit",
        airline: @airline_1
      })

      @passenger_1 = Passenger.create({
        name: "Phillip Fry",
        age: 31
      })

      @passenger_2 = Passenger.create({
        name: "James McAvoy",
        age: 47
      })

      @passenger_3 = Passenger.create({
        name: "Ameesh Paktra",
        age: 36
      })

      @passenger_4 = Passenger.create({
        name: "Small Fry",
        age: 13
      })

      @flight_1.passengers << [@passenger_1, @passenger_2, @passenger_3, @passenger_4]

    }



    it "total_adults" do
      expect(@flight_1.total_adults(true)).to eq(3)
    end
  end
end
