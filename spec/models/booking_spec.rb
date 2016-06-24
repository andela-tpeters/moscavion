require 'rails_helper'

RSpec.describe Booking, type: :model do
	describe '#instantiation' do
	  it 'returns booking object' do
	  	booking = build(:booking)
	  	expect(booking).to be_kind_of(Booking)
	  end
	end

	describe '#save' do
		subject { build(:booking) } 
	  it 'saves booking object' do
	  	subject.save
	  	expect(Booking.all.size).to be(1)
	  	expect(Booking.all).to include(subject)
	  end

	  it 'creates booking object' do
	  	expect(create(:booking).booking_code).to be(123456)
	  end

	  it 'changes booking_code' do
	  	subject.booking_code = 654321
	  	subject.save

	  	booking = Booking.find_by(booking_code: 654321)
	  	expect(booking.id).to be(1)
	  end
	end

	describe 'association' do
		subject { build(:booking) } 
	  it 'is associated with flight' do
	  	expect(subject.flight.departure_location).to eql("Lagos")
	  end

	  it 'is associated with an airport' do
	  	binding.pry
	  	expect(subject.flight.airport.name).to eql("Heathrow")
	  end

	  it 'update associated with an airport' do
	  	airport = Airport.create attributes_for(:airport, :name => "Kilimanjaro")
	  	flight = Flight.create attributes_for(:flight, :departure_location => "Kogi")
	  	flight.airport = airport
	  	booking = Booking.new attributes_for(:booking)
	  	booking.flight = flight
	  	booking.save
	  	booking = Booking.first
	  	expect(booking.flight.airport.name).to eq("Kilimanjaro")
	  	expect(booking.flight.departure_location).to eq("Kogi")
	  end
	end

	describe '#instantiation errors' do
	  it 'raises error if string is passed to prices' do
	  	expect { create(:booking, :price => "twenty") }
	  					.to raise_error ActiveRecord::RecordInvalid
	  end

	  it 'raises error if input is nil' do
	  	expect { create(:booking, :price => nil) }
	  					.to raise_error ActiveRecord::RecordInvalid
	  end
	end
end
