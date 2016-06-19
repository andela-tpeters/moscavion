require 'rails_helper'

RSpec.describe Flight, type: :model do
	describe "#instantiation" do
		it 'should create and object' do
			flight = build(:flight)

			expect(flight).to be_kind_of(Flight)
			expect(Flight.all.size).to eql(0)

			flight.save

			expect(Flight.all.size).to eql(1)
			flight2 = create(:flight)

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
			expect(flight.airline).to eql("Sosoliso Airline")
			expect(flight.price).to eql(250000.50)
			expect(flight.airports_id).to eq(1)
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

			expect { create(:flight, airports_id: nil) }
							.to raise_error ActiveRecord::RecordInvalid
		end

		it 'should raise ArgumentError for incomplete arguments' do
			data = {:departure_location => "Lagos",
							:arrival_location => "Kaduna",
							:airports_id => 1 }
			expect { create(data) }.to raise_error ArgumentError
		end

		it 'should raise error when passed wrong datatype' do
			expect { create(:flight, departure_location: 1000) }
							.to raise_error ActiveRecord::RecordInvalid
			expect { create(:flight, arrival_location: 1000) }
							.to raise_error ActiveRecord::RecordInvalid
			expect { create(:flight, airline: 1000) }
							.to raise_error ActiveRecord::RecordInvalid
			expect { create(:flight, airports_id: "one") }
							.to raise_error ActiveRecord::RecordInvalid
		end
	end
end
