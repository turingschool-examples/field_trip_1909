require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    # it {should have_many :flight}
    it {should have_many :passanger_flights}
    it {should have_many(:flights).through(:passanger_flights)}
  end
end
