require 'rails_helper'

RSpec.describe BookingController, type: :controller do
	let(:new_booking) { {
			:flight_id => Flight.first,
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

	describe '#session' do
	  context 'when a user is not logged in' do
	  	it "should return false logged_in?" do
	  		post_new
	  		expect(controller.send(:logged_in?)).to be_falsey
	  	end

	  	it "redirects the user to the login page" do
	  		post_new
	  		expect(response).to redirect_to(root_path)
	  	end
	  end
	end

	describe '#new' do
		before do
			session[:user_id] = 1
		end

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

	describe 'user bookings' do
	  before do
	  	user_ids = [1,2,1,3,4,2,3,2,1,1]
			user_ids.each do |id|
	  		session[:user_id] = id
				new_booking[:flight_id] = Flight.offset(rand(Flight.count)).first
				new_booking[:user_id] = User.find_by(:id => id)
				post_new
			end
	  end

	  context 'when user has made bookings' do
	  	it "returns bookings perculiar to the user 1" do
	  		get :index
	  		expect(assigns(:bookings).size).to eql(4)
	  	end

	  	it "returns bookings for user 2" do
	  		session[:user_id] = 2
	  		get :index
	  		expect(assigns(:bookings).size).to eql(3)
	  	end

	  	it 'returns nothing for user 4' do
	  		session[:user_id] = 4
	  		get :index
	  		expect(response).to redirect_to(login_page_path)
	  	end
	  end
	end

	describe 'booking <> passengers' do
	  it 'saves passenger for booking' do
	  	session[:user_id] = 1
	  	new_booking[:passengers_attributes] = [{:first_name => "Tijesunimi",
	  																					:last_name => "Peters",
	  																					:email => "tijesunimi@gmail.com"}]
	  	post_new
	  	passenger = Passenger.find_by(:booking_id => 1)
	  	expect(passenger.first_name).to eql("Tijesunimi")
	  end

	  it 'does not save passenger for booking' do
	  	session[:user_id] = 1
	  	new_booking[:passengers_attributes] = []
	  	post_new
	  	expect(Passenger.all.size).to eql(0)
	  end
	end
end
