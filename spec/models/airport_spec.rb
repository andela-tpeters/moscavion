require 'rails_helper'

RSpec.describe Airport, type: :model do
	describe '#instantiation' do
	  it 'should be an instance of Airport' do
	  	airport = build(:airport)
	  	expect(airport).to be_kind_of(Airport)  
	  end
	end

	describe '#save' do
	  it 'should be able to save' do
	  	airport = build(:airport)
	  	expect(airport.new_record?).to be_truthy

	  	expect(Airport.all.size).to eql(0)

	  	airport.save

	  	expect(Airport.all).to include(airport)

	  	find_airport = Airport.find_by(name: "Heathrow")
	  	expect(find_airport).to eql(airport)
	  	expect(find_airport.longitude).to eql(airport.longitude)
	  end
	end

	describe "#create" do
  	it 'should create airport and save' do
  		expect(Airport.all).to be_empty

  		airport = create(:airport)

  		expect(Airport.all).to match([airport])
  		expect(Airport.all).to include(airport)

  		airport2 = create(:airport, :name => "Murtala Muhammed II")

  		expect(Airport.all).to include(airport2)
  		expect(Airport.all).to match([airport, airport2])
  	end
  end

  describe "#instantiation" do
  	it 'should raise error incomplete parameters' do
  		attributes = {:name => "Ilorin"}
  		expect { Airport.create!(attributes) }.to raise_error ActiveRecord::RecordInvalid
  		expect(Airport.all.size).to eql(0)
  	end

  	it 'should raise error for nil value' do
  		expect { build(:airport, :name => nil).save! }
  		        .to raise_error ActiveRecord::RecordInvalid
  		expect { build(:airport, :city => nil).save! }
  		        .to raise_error ActiveRecord::RecordInvalid
  		expect { build(:airport, :country => nil).save! }
  		        .to raise_error ActiveRecord::RecordInvalid
  		expect { build(:airport, :latitude => nil).save! }
  		        .to raise_error ActiveRecord::RecordInvalid
  		expect { build(:airport, :longitude => nil).save! }
  		        .to raise_error ActiveRecord::RecordInvalid
  		expect { build(:airport, :name => "").save! }
  		        .to raise_error ActiveRecord::RecordInvalid
  	end

  	it 'should raise error for input other than strings' do
  		expect { create(:airport, :name => 1234) }
  						.to raise_error ActiveRecord::RecordInvalid
  		expect { create(:airport, :name => true) }
  						.to raise_error ActiveRecord::RecordInvalid
  	end

  	it 'should raise error for input other than integer or floats' do
  		expect { create(:airport, :longitude => true) }
  						.to raise_error ActiveRecord::RecordInvalid
  		expect { create(:airport, :latitude => "string") }
  						.to raise_error ActiveRecord::RecordInvalid
  	end
  end

  describe "Airport has many Flights" do
  	before(:all) do
  	  @airport = build(:airport)
	  	@flight = build(:flight, :id => 1)
	  	@flight2 = build(:flight, :arrival_location => "Kogi", :id => 2)
	  	@flight3 = build(:flight, :arrival_location => "Bayelsa", :id => 3)
  	end

  	after(:each) do
  	  @airport.flights.clear
  	end

  	it 'should all flights for an airport' do
	  	@airport.flights << @flight
	  	@airport.flights << @flight2
	  	@airport.flights << @flight3
	  	expect(@airport.flights.size).to eql(3)
  	end

  	it 'should not duplicates' do
  		@airport.flights << @flight
  		@airport.flights << @flight
  		expect(@airport.flights.size).to eql(1)
  	end

  	it 'should include flights saved' do
  		@airport.flights << @flight
	  	@airport.flights << @flight2
	  	@airport.flights << @flight3
  		expect(@airport.flights).to include(@flight2)
  	end
  end
end
