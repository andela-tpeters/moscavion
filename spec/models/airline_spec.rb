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

	describe 'airport association' do
	  it 'belongs to airport' do
	  	airline = create(:airline)
	  	expect(airline.airport.name).to eql("Heathrow")
	  end

	  it 'updates airport' do
	  	
	  end
	end
end
