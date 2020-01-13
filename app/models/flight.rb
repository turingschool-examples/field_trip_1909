class Flight <ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  def total_minor_passengers
    passengers.where('age < 18').count
  end

  def total_adult_passengers
    passengers.where('age >= 18').count
  end
end
