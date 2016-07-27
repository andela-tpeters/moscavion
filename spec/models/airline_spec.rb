require 'rails_helper'

RSpec.describe Airline, type: :model do
	describe 'association' do
	  it 'belongs to airport' do
	  	airline = create(:airline)
	  	expect(airline.airport.name).to eql("Heathrow")
	  end

	  it 'updates airline' do
	  	airline = create :airline
	  	airline_from_db = Airline.find_by(:id => 1)
	  	expect(airline_from_db.name).to eq("Arik")

	  	airline_from_db.name = "Sosoliso Airline"
	  	airline_from_db.icao = "SSS"
	  	airline_from_db.iata = "SSA"
	  	airline_from_db.save

	  	airline = Airline.find_by(:id => 1)
	  	expect(airline.name).to eq("Sosoliso Airline")
	  end

	  it 'updates airport' do
	  	airline = create :airline
	  	expect(airline.airport.name).to eql("Heathrow")

	  	airline = Airline.first
	  	airport = create(:airport, :name => "Ibadan", :id => 2)
	  	airline.airport = airport
	  	airline.save
	  	expect(Airline.first.airport.name).to eq("Ibadan")
	  end
	end
end
