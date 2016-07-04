require 'rails_helper'

RSpec.describe BookingController, type: :controller do
	let(:new_booking) { {
			:flight_id => Flight.first,
			:user_id => User.first,
			:booking_code => Faker::Number.number(5),
			:price => Faker::Commerce.price
		} }

	before do
	  load "#{Rails.root}/spec/support/seed.rb" 
  	Seed.all
	end

	def post_new
		request.env["HTTP_REFERER"] = new_booking_path
		post :new, :new_booking => new_booking
	end

	describe '#new' do
		context 'when user fills form new booking' do
			it 'should save booking and redirect to your_bookings_path' do
				post_new
				expect(response).to redirect_to(your_bookings_path)
				expect(Booking.find_by(:flight_id => 1).flight).to eql(new_booking[:flight_id])
			end
		end

		context 'when user enters empty data' do
			it 'raise error' do
				new_booking.clear
				expect{ post_new }.to raise_error ActionController::ParameterMissing
			end
		end

		context 'when parameters are nil' do
			it 'raise error' do
				new_booking[:flight_id] = nil
				post_new
				expect(response).to redirect_to(new_booking_path)
			end
		end
	end
end
