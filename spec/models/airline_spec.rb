require 'rails_helper'

RSpec.describe Airline, type: :model do
	describe '#instantiation' do
	  it 'creates airline object' do
	  	airline = build(:airline)
	  	expect(airline.name).to eql("Arik")
	  end

	  it 'saves airline object' do
	  	airline = build(:airline)
	  	airline.save
	  	expect(Airline.all).to include(airline)
	  end

	  it 'instantiates and saves airline object' do
	  	airline = create(:airline)
	  	expect(Airline.all).to include(airline)
	  end
	end

	describe 'airline flights' do
	  it 'saves many flights' do
	  	airline = build(:airline)
	  	expect(airline.flights.size).to eq(0)

	  	airline.flights << create(:flight)
	  	expect(airline.flights.first.departure_location).to eq("Lagos")

	  	flight2 = create(:flight, :id => 2, :departure_location => "Congo", :arrival_location => "Ibadan")
	  	airline.flights << flight2
	  	expect(airline.flights.last.departure_location).to eq("Congo")
	  	expect(airline.flights.size).to eql(2)
	  end
	end

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
