require 'rails_helper'

RSpec.describe User, type: :model do
	describe '#instantiation' do
	  it 'builds user object' do
	  	user = build(:user)
	  	expect(user).to be_kind_of(User)
	  end

	  it '#saves user' do
	  	user = create(:user)
	  	expect(User.first.first_name).to eq("Tijesunimi")
	  end
	end

	describe 'validations for new users' do
	  it 'raises error for input < 6 characters' do
	  	expect { create(:user, :first_name => "Toms") }
	  					.to raise_error ActiveRecord::RecordInvalid
	  	expect { create(:user, :last_name => "Toms") }
	  					.to raise_error ActiveRecord::RecordInvalid
	  end

	  it 'raises error for nil input' do
	  	expect { create(:user, :first_name => nil) }
	  					.to raise_error ActiveRecord::RecordInvalid
	  	expect { create(:user, :first_name => nil) }
	  					.to raise_error ActiveRecord::RecordInvalid
	  end

	  it 'raises error on nil password' do
	  	expect { create(:user, :password => nil) }
	  				.to raise_error ActiveRecord::RecordInvalid
	  	expect(User.all.empty?).to be_truthy
	  end

	  it 'raises error for wrong email address format' do
	  	expect { create(:user, :email => "tijesunimi.com") }
	  						.to raise_error ActiveRecord::RecordInvalid
	  end
	end

	describe 'password' do
	  it 'returns password string of 60 characters' do
	  	user = build(:user)
	  	expect(user.password.length).to eql(60)
	  end
	end
end
