require "rails_helper"

RSpec.describe "flights#show" do
  before {

    @airline_1 = Airline.create!({
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

    visit "/flights/#{@flight_1.id}"
  }

  context "user visits 'flights/:id' page" do
    it "displays the flights: number, date, time, departure and arrival cities" do
      within(".flight-overview") do
        expect(page).to have_content(@flight_1.number)
        expect(page).to have_content(@flight_1.date)
        expect(page).to have_content(@flight_1.time)
        expect(page).to have_content(@flight_1.departure_city)
        expect(page).to have_content(@flight_1.arrival_city)
      end
    end

    it "displays the name of the airline the flight belongs to" do
      within(".flight-overview") do
        expect(page).to have_content(@flight_1.airline.name)
      end
    end

    it "displays the names of all the passengers on the flight" do

    end
  end
end