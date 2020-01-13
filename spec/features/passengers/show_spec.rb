require "rails_helper"

RSpec.describe "passengers#show" do
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

    @flight_2 = Flight.create({
      number: "123456",
      date: '2020-01-06',
      time: "7:25",
      departure_city: "Dentroit",
      arrival_city: "Denver",
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

    @flight_1.passengers << [@passenger_1, @passenger_2, @passenger_3]

    visit "/passengers/#{@passenger_1.id}"
  }

  context "user visits 'passengers/:id' page" do
    it "displays the passengers name" do
      within(".passenger-overview") do
        expect(page).to have_content(@passenger_1.name)
      end
    end

    it "displays all the flight numbers associated with that passenger" do
      within(".flights-dossier") do
        expect(page).to have_link("Flight ##{@flight_1.number}", href: "/flights/#{@flight_1.id}")
      end
    end

    it "passenger associated flights are links to the respective flight show page" do
      within(".flights-dossier") do
        click_on "Flight ##{@flight_1.number}"
        expect(current_path).to eq("/flights/#{@flight_1.id}")
      end
    end

    it "contains a form to add the current passenger to an already existing flight" do
      within(".flight-booking") do
        expect(page).to have_content("Book a Flight")
        expect(page).to have_content("Flight number")
        expect(page).to have_button("Book")
      end
    end

    it "when user books a flight, they are added to the flight" do
      within(".flight-booking") do
        fill_in :flight_number, with: 123456
        click_on "Book"
        expect(@flight_2.passengers.count).to eq(1)
        expect(current_path).to eq("/passengers/#{@passenger_1.id}")
      end
    end
  end
end