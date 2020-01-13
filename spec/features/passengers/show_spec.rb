require 'rails_helper'

RSpec.describe "when i visit the passengers show page i
see the name of pas flight numbers of the passager flights as a
link"do
    it 'can display all theis stuff' do
      southwest = Airline.create(name: "Southwest")
      flight = southwest.flights.create(number: '1092', date: '1/2/3', time: '28', departure_city: 'lakewood', arrival_city: 'denver')
      michel = flight.passengers.create(name: 'santi', age:605)
      flig_2 = michel.flights.create(number: '123', date: '1/2/3', time: '28', departure_city: 'lakewood', arrival_city: 'denver')
      jon = flight.passengers.create(name: 'jhon', age:65)

      visit "/passengers/#{michel.id}"
      expect(page).to have_content('santi')
      expect(page).to have_link('1092')

      click_on '1092'

      expect(current_path).to eq("/flights/#{flight.id}")

    end
    it 'i see a link to add to add a flight' do
      southwest = Airline.create(name: "Southwest")
      flight = southwest.flights.create(number: '1092', date: '1/2/3', time: '28', departure_city: 'lakewood', arrival_city: 'denver')
      michel = flight.passengers.create(name: 'santi', age:605)

      visit "/passengers/#{michel.id}"

      expect(page).to have_link('Add Flight')

      click_on 'Add Flight'

      # visit "/passengers/#{michel.id}/new/flight"




    end
  end
