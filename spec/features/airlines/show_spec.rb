require 'rails_helper'

RSpec.describe "Airline Show Spec" do
  describe "When I visit the airline show page" do
    it 'I can see that airlines name and all its flights' do
      southwest = Airline.create(name: "Southwest")

      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      southwest_2 = southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      visit "/airlines/#{southwest.id}"

      expect(page).to have_content(southwest.name)

      within "#flight-#{southwest_1.id}" do
        expect(page).to have_content("Flight Number: #{southwest_1.number}")
        expect(page).to have_content("Date: #{southwest_1.date}")
        expect(page).to have_content("Time: #{southwest_1.time}")
        expect(page).to have_content("Departure City: #{southwest_1.departure_city}")
        expect(page).to have_content("Arrival City: #{southwest_1.arrival_city}")
      end

      within "#flight-#{southwest_2.id}" do
        expect(page).to have_content("Flight Number: #{southwest_2.number}")
        expect(page).to have_content("Date: #{southwest_2.date}")
        expect(page).to have_content("Time: #{southwest_2.time}")
        expect(page).to have_content("Departure City: #{southwest_2.departure_city}")
        expect(page).to have_content("Arrival City: #{southwest_2.arrival_city}")
      end

      end
      it "can visit the airline show page and see passengers of the airline" do
        southwest = Airline.create(name: "Southwest")
        flight_1 = southwest.flights.create(number:'281', date:'1/2/3', time:'2:34', departure_city: 'Chihuahua', arrival_city: 'Denver' )
        flight_2 = southwest.flights.create(number:'282', date:'1/2/4', time:'2:40', departure_city: 'Chihuahua', arrival_city: 'Denver' )
        jon = flight_1.passengers.create(name: 'jon', age:300)
        max = flight_1.passengers.create(name: 'max', age:13)
        peet = flight_2.passengers.create(name: 'peet', age:20)
        gary = flight_2.passengers.create(name: 'gary', age:26)

        visit "/airlines/#{southwest.id}"

        expect(page).to have_content('jon')
        expect(page).to have_content('max')
        expect(page).to have_content('peet')
        expect(page).to have_content('gary')
        
    end
  end
end
