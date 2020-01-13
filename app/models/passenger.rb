class Passenger < ApplicationRecord
  has_many :passanger_flights
  has_many :flights, through: :passanger_flights
  validates_presence_of :name,
                        :age



end
