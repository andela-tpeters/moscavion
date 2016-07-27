require 'rails_helper'

RSpec.describe Flight, type: :model do
	describe "#instantiation" do
		it 'should create and object' do
			flight = build(:flight)

			expect(flight).to be_kind_of(Flight)
			expect(Flight.all.size).to eql(0)

			flight.save

			expect(Flight.all.size).to eql(1)
			flight2 = create(:flight, :departure_location => "Lokoja", :id => 2)

			expect(Flight.all.size).to eql(2)
			expect(Flight.all).to include(flight)
			expect(Flight.all).to include(flight2)
		end

		it 'should return a flight object' do
			flight = create(:flight)

			expect(flight).to_not be_nil
			expect(flight.departure_location).to eql("Lagos")
			expect(flight.arrival_location).to eql("Kaduna")
			expect(flight.departure_date.to_s)
						.to eql("2016-06-17 09:00:00 UTC")
			expect(flight.arrival_date.to_s)
						.to eql("2016-06-18 09:00:00 UTC")
			expect(flight.price).to eql(250000.50)
		end
	end

	describe "#instantiation errors" do
		it 'should raise ActiveRecord::RecordInvalid error' do
			expect { create(:flight, departure_location: nil) }
						  .to raise_error ActiveRecord::RecordInvalid

			expect { create(:flight, arrival_location: nil) }
							.to raise_error ActiveRecord::RecordInvalid

			expect { create(:flight, departure_date: nil) }
							.to raise_error ActiveRecord::RecordInvalid
		end

		it 'should raise ArgumentError for incomplete arguments' do
			data = {:departure_location => "Lagos",
							:arrival_location => "Kaduna",
							:airport_id => 1 }

			expect( Flight.new(data).save ).to be_falsey
			expect { Flight.create!(data) }.to raise_error ActiveRecord::RecordInvalid
		end

		it 'should raise error when passed wrong datatype' do
			expect { create(:flight, departure_location: 1000) }
							.to raise_error ActiveRecord::RecordInvalid
			expect { create(:flight, arrival_location: 1000) }
							.to raise_error ActiveRecord::RecordInvalid
		end
	end

	describe 'Flight belongs to Airport' do
		before(:each) do
		  @airport = build(:airport)
		  @flight = build(:flight)
		end

		it 'accepts airport for flight' do
		  @flight.airport = @airport
		  expect(@flight.airport).to eq(@airport)
		end

		it 'changes airport for flight' do
		  @flight.airport = build(:airport, :name => "Ilorin", :id => 1)
		  expect(@flight.airport.name).to eql("Ilorin")
		end
	end
end
