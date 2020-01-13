require "rails_helper"

RSpec.describe "flights#show" do
  before {

    @airline_1 = Airline.create({
      name: "Southwest Airlines"
    })

    @flight_1 = Flight.create({
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
      within(".passenger-dossier") do
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_1.age)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_2.age)
        expect(page).to have_content(@passenger_3.name)
        expect(page).to have_content(@passenger_3.age)
      end
    end

    it "displays number of minors and non-minor passengers on the flight" do
      within(".passenger-metrics") do
        expect(page).to have_content("Adults: 3")
        expect(page).to have_content("Minors: 1")
      end
    end
  end
end