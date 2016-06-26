require 'rails_helper'

RSpec.describe Passenger, type: :model do
	describe '#instantiation' do
	  it 'builds a passenger object' do
	  	passenger = build(:passenger)
	  	expect(passenger).to be_kind_of(Passenger)
	  end
	end

	describe '#save' do
		it 'saves a passenger object to the database' do
			passenger = build :passenger
		  passenger.save

		  expect(Passenger.all).to include(passenger)
		end

		it 'builds a passenger object and saves to the database' do
			passenger = create :passenger
			expect(Passenger.all).to include(passenger)
		end
	end

	describe 'validations' do
	  it 'raises error on wrong email format' do
	  	expect { create(:passenger, :email => "tijesunimi.com") }
	  						.to raise_error ActiveRecord::RecordInvalid
		  expect { create(:passenger, :email => nil) }
		  						.to raise_error ActiveRecord::RecordInvalid
		end

		it 'raises error for nil last name or first name' do
			expect { create(:passenger, :first_name => '') }
							.to raise_error ActiveRecord::RecordInvalid
			expect { create(:passenger, :last_name => nil) }
							.to raise_error ActiveRecord::RecordInvalid
		end

		it 'raises error for length  < 3' do
			expect { create(:passenger, :first_name => "GO") }
							.to raise_error ActiveRecord::RecordInvalid
		end
	end
end
