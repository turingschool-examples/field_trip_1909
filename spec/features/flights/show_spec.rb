require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a flight's show page" do
    it "I see all of that flight's info including number, date, time, departure city, arrival city" do
      southwest = Airline.create(name: "Southwest")
      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      southwest_2 = southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      visit "/flights/#{southwest_1.id}"

      expect(page).to have_content("SW1")
      expect(page).to have_content("10/10/20")
      expect(page).to have_content("1300")
      expect(page).to have_content("Minneapolis")
      expect(page).to have_content("Nashville")
    end

    it "I see the name of the airline the flight belongs to and the names of all passengers on this flight" do
      southwest = Airline.create(name: "Southwest")
      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      ralph = Passenger.create(name: "Ralph Ralpherson", age: 10)
      don = Passenger.create(name: "Don Donaldson", age: 31)
      john = Passenger.create(name: "John Johnson", age: 50)
      rando = Passenger.create(name: "Rando Randerson", age: 5)

      southwest_1.passengers << [ralph, don, john, rando]

      visit "/flights/#{southwest_1.id}"

      expect(page).to have_content("SW1")
      expect(page).to have_content("10/10/20")
      expect(page).to have_content("1300")
      expect(page).to have_content("Minneapolis")
      expect(page).to have_content("Nashville")
      expect(page).to have_content(southwest.name)

      within "#passenger-#{ralph.id}" do
        expect(page).to have_content(ralph.name)
        expect(page).to have_content(ralph.age)
      end

      within "#passenger-#{don.id}" do
        expect(page).to have_content(don.name)
        expect(page).to have_content(don.age)
      end

      within "#passenger-#{john.id}" do
        expect(page).to have_content(john.name)
        expect(page).to have_content(john.age)
      end

      within "#passenger-#{rando.id}" do
        expect(page).to have_content(rando.name)
        expect(page).to have_content(rando.age)
      end
    end

    it "I see the number of minors (under 18) and adults (over 18) on a flight" do
      southwest = Airline.create(name: "Southwest")
      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      ralph = Passenger.create(name: "Ralph Ralpherson", age: 10)
      don = Passenger.create(name: "Don Donaldson", age: 31)
      john = Passenger.create(name: "John Johnson", age: 50)
      rando = Passenger.create(name: "Rando Randerson", age: 5)
      harris = Passenger.create(name: "Harris Harrison", age:15)

      southwest_1.passengers << [ralph, don, john, rando, harris]

      visit "/flights/#{southwest_1.id}"

      expect(page).to have_content("Minors: 3")
      expect(page).to have_content("Adults: 2")
    end
  end
end
