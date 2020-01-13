class Flight <ApplicationRecord
  has_many :passanger_flights
  has_many :passengers, through: :passanger_flights

  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  belongs_to :airline

end
