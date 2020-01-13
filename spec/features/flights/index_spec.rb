require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @southwest = Airline.create(name: "Southwest")

    @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

    @passenger_1 = Passenger.create(name: 'Daniel Frampton', age: '45')
    @passenger_2 = Passenger.create(name: 'Jamie Frampton', age: '42')
    @passenger_3 = Passenger.create(name: 'Evalyn Frampton', age: '10')
    @passenger_4 = Passenger.create(name: 'Denison Frampton', age: '8')
    @passenger_5 = Passenger.create(name: 'Elodie Frampton', age: '5')
    @passenger_6 = Passenger.create(name: 'Henley Frampton', age: '4')

    @southwest_1.passengers << [@passenger_1, @passenger_3, @passenger_4]
    @southwest_2.passengers << [@passenger_2, @passenger_6, @passenger_5]
  end

  describe "When I visit a flights show page ('/flights/:id')" do
    it "I see the flight's number, date, time, departure city, and arrival city" do
      visit "/flights/#{@southwest_1.id}"

      expect(page).to have_content("Flight Details")
      expect(page).to have_content("Flight Number: #{@southwest_1.number}")
      expect(page).to have_content("Date: #{@southwest_1.date}")
      expect(page).to have_content("Time: #{@southwest_1.time}")
      expect(page).to have_content("Departure City: #{@southwest_1.departure_city}")
      expect(page).to have_content("Arrival City: #{@southwest_1.arrival_city}")

      visit "/flights/#{@southwest_2.id}"

      expect(page).to have_content("Flight Details")
      expect(page).to have_content("Flight Number: #{@southwest_2.number}")
      expect(page).to have_content("Date: #{@southwest_2.date}")
      expect(page).to have_content("Time: #{@southwest_2.time}")
      expect(page).to have_content("Departure City: #{@southwest_2.departure_city}")
      expect(page).to have_content("Arrival City: #{@southwest_2.arrival_city}")
    end

    it 'And I see the name of the airline this flight belongs' do
      visit "/flights/#{@southwest_1.id}"

      expect(page).to have_content(@southwest_1.airline)

      visit "/flights/#{@southwest_2.id}"

      expect(page).to have_content(@southwest_2.airline)
    end

    it 'And I see the names of all of the passengers on this flight' do
      visit "/flights/#{@southwest_1.id}"

      expect(page).to have_content("Passengers On This Flight")
      expect(page).to have_content("#{@passenger_1}")
      expect(page).to have_content("#{@passenger_3}")
      expect(page).to have_content("#{@passenger_4}")

      visit "/flights/#{@southwest_2.id}"

      expect(page).to have_content("Passengers On This Flight")
      expect(page).to have_content("#{@passenger_2}")
      expect(page).to have_content("#{@passenger_5}")
      expect(page).to have_content("#{@passenger_6}")
    end
  end
end
