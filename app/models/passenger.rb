class Passenger < ApplicationRecord
  validates_presence_of :name, :age

  has_many :flight_passengers
  has_many :flights, through: :flight_passengers

  def self.minors
    # require "pry"; binding.pry
    joins(:flights).group(:id).where('passengers.age < 18').count(:passengers)
  end
end
