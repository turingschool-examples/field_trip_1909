require 'rails_helper'

RSpec.describe "when i visit the show page i see- number
  - date
  - time
  - departure city
  - arrival city
  and the name of the airline and passagers on the flight"do
    it 'can display all theis stuff' do
      southwest = Airline.create(name: "Southwest")
      flight = southwest.flights.create(number: '1092', date: '1/2/3', time: '28', departure_city: 'lakewood', arrival_city: 'denver')
      michel = flight.passengers.create(name: 'santi', age:605)
      jon = flight.passengers.create(name: 'jhon', age:65)

      visit "flights/#{flight.id}"
      expect(page).to have_content('Southwest')
      expect(page).to have_content('1092')
      expect(page).to have_content('1/2/3')
      expect(page).to have_content('28')
      expect(page).to have_content('lakewood')
      expect(page).to have_content('denver')
      expect(page).to have_content('santi')
      expect(page).to have_content('jhon')

    end
  end
