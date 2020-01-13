require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @southwest = Airline.create(name: "Southwest")

    @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
    @southwest_3 = @southwest.flights.create(number: "SW3", date: "1/01/20", time: "1100", departure_city: "Nashville", arrival_city: "Minneapolis")
    @southwest_4 = @southwest.flights.create(number: "SW4", date: "1/02/20", time: "1400", departure_city: "Oakland", arrival_city: "Baltimore")

    @passenger_1 = Passenger.create(name: 'Daniel Frampton', age: '45')
    @passenger_2 = Passenger.create(name: 'Jamie Frampton', age: '42')
    @passenger_3 = Passenger.create(name: 'Evalyn Frampton', age: '10')
    @passenger_4 = Passenger.create(name: 'Denison Frampton', age: '8')
    @passenger_5 = Passenger.create(name: 'Elodie Frampton', age: '5')
    @passenger_6 = Passenger.create(name: 'Henley Frampton', age: '4')

    @southwest_1.passengers << [@passenger_1, @passenger_3, @passenger_4]
    @southwest_2.passengers << [@passenger_2, @passenger_6, @passenger_5]
    @southwest_3.passengers << [@passenger_1, @passenger_3, @passenger_4]
    @southwest_4.passengers << [@passenger_2, @passenger_6, @passenger_5]
  end

  describe "When I visit a passengers show page ('/passengers/:id')" do
    it 'I see that passengers name' do
      visit "/passengers/#{@passenger_1.id}"

      expect(page).to have_content("Name: #{@passenger_1.name}")
    end

    it "I see a section of the page that displays all flight numbers of the flights for that passenger" do
      visit "/passengers/#{@passenger_1.id}"

      expect(page).to have_content("All Flights for This Passenger")
      expect(page).to have_content("#{@southwest_1.number}")
      expect(page).to have_content("#{@southwest_3.number}")

      visit "/passengers/#{@passenger_2.id}"

      expect(page).to have_content("All Flights for This Passenger")
      expect(page).to have_content("#{@southwest_2.number}")
      expect(page).to have_content("#{@southwest_4.number}")
    end

    it "I see all flight numbers listed link to that flights show page" do
      visit "/passengers/#{@passenger_1.id}"

      expect(page).to have_link("#{@southwest_1.number}", href: "/flights/#{@southwest_1.id}")
      expect(page).to have_link("#{@southwest_3.number}", href: "/flights/#{@southwest_3.id}")
    end

    it 'I see a form to add a flight' do
      visit "/passengers/#{@passenger_1.id}"

      expect(page).to have_content("Add a Flight")
      expect(page).to have_field('Flight Number')
      expect(page).to have_button('Add Flight')
    end

    describe 'When I fill in the form with a flight number and click submit' do
      before(:each) do
        visit "/passengers/#{@passenger_1.id}"
        fill_in 'Flight Number', with: "SW5"
        click_on 'Add Flight'
      end

      it "I'm taken back to the passengers show page" do
        expect(current_path).to eq("/passengers/#{@passenger_1.id}")
      end

      it "And I can see the flight number of the flight I just added" do
        expect(page).to have_content("SW5")
      end
    end
  end
end
