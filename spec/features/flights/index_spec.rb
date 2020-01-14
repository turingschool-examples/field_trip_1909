require 'rails_helper'

RSpec.describe "flights Index Spec" do
  it "can display the number of the plane in the index" do
    southwest = Airline.create(name: "Southwest")
    flight_1 = southwest.flights.create(number:'281', date:'1/2/3', time:'2:34', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    flight_2 = southwest.flights.create(number:'282', date:'1/2/4', time:'2:40', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    jon = flight_1.passengers.create(name: 'jon', age:300)
    max = flight_1.passengers.create(name: 'max', age:13)
    peet = flight_2.passengers.create(name: 'peet', age:20)


    visit '/flights'

    expect(page).to have_content('281')
    expect(page).to have_content('jon')
    expect(page).to have_content('max')

    expect(page).to have_content('282')
    expect(page).to have_content('peet')
  end
  it "can have a link next to each passanger to remove them from the flight" do
    southwest = Airline.create(name: "Southwest")
    flight_1 = southwest.flights.create(number:'281', date:'1/2/3', time:'2:34', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    jon = flight_1.passengers.create(name: 'jon', age:300)

    visit '/flights'

    expect(page).to have_content('Remove from flight')
    expect(page).to have_content('jon')

    click_link 'Remove from flight'
    expect(page).to_not have_content('jon')

  end
  it "can see all passangers and there name and there flight number" do
    southwest = Airline.create(name: "Southwest")
    flight_1 = southwest.flights.create(number:'281', date:'1/2/3', time:'2:34', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    jon = flight_1.passengers.create(name: 'jon', age:300)


    visit '/passengers'

    expect(page).to have_content('jon')
    expect(page).to have_content('281')

  end
  it "can see all passangers and there name and there flight number" do
    southwest = Airline.create(name: "Southwest")
    flight_1 = southwest.flights.create(number:'281', date:'1/2/3', time:'2:34', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    flight_2 = southwest.flights.create(number:'282', date:'1/2/4', time:'2:40', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    peet = flight_2.passengers.create(name: 'peet', age:20)

    visit '/passengers'

    expect(page).to have_content('peet')
    expect(page).to have_content('282')

  end
  it "can see all passangers and flights with diferent airline" do
    southwest = Airline.create(name: "Southwest")
    volaris = Airline.create(name: "volaris")
    flight_1 = volaris.flights.create(number:'281', date:'1/2/3', time:'2:34', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    flight_2 = southwest.flights.create(number:'282', date:'1/2/4', time:'2:40', departure_city: 'Chihuahua', arrival_city: 'Denver' )
    eric = flight_1.passengers.create(name: 'eric', age:22)
    peet = flight_2.passengers.create(name: 'peet', age:20)
    alex = flight_2.passengers.create(name: 'alex', age:20)

    visit '/passengers'


    expect(page).to have_content('peet 282')
    expect(page).to have_content('eric 281')
    expect(page).to have_content('alex 282')

  end
end
