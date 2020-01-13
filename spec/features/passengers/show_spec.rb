require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a passenger's show page" do
    it "I see that passengers name and a section which displays all flight numbers (as links to that flight's show page) of the flights for that passenger" do
      southwest = Airline.create(name: "Southwest")
      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      southwest_2 = southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
      rando = Passenger.create(name: "Rando Randerson", age: 27)

      rando.flights << [southwest_1, southwest_2]

      visit "/passengers/#{rando.id}"

      expect(page).to have_content(rando.name)
      expect(page).to have_content("All flights:")

      within "#flight-#{southwest_1.id}" do
        expect(page).to have_link(southwest_1.number)
      end

      within "#flight-#{southwest_2.id}" do
        click_link "#{southwest_2.number}"
      end

      expect(current_path).to eq("/flights/#{southwest_2.id}")
    end
  end
end
