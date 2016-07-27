require 'rails_helper'

RSpec.describe Passenger, type: :model do
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
