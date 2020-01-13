# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
