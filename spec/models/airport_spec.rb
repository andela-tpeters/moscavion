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
	end
end
