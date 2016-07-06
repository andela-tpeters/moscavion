require 'rails_helper'

RSpec.describe BookingController, type: :controller do
	let(:new_booking) { {
			:flight_id => Flight.first,
			:price => Faker::Commerce.price
		} }

		
	before(:all) do
	  load "#{Rails.root}/spec/support/seed.rb" 
  	Seed.all
	end

	def post_new
		request.env["HTTP_REFERER"] = new_booking_path
		post :new, :booking => new_booking
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
			[1,2,1,3,4,2,3,2,1,1].each do |id|
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

	describe 'manage' do
		before do
			new_booking[:flight_id] = Flight.offset(rand(Flight.count)).first
			new_booking[:passengers_attributes] = [{:first_name => "Kongas",
	  																					:last_name => "Peters",
	  																					:email => "Konga@gmail.com"},
	  																					{:first_name => "Bongos",
	  																					:last_name => "Blueking",
	  																					:email => "bongos@gmail.com"}]
			post_new
	  end
	  context 'when user inputs booking code' do
	  	let(:reservation) { Booking.last }
	  	
	  	it 'returns the reservation' do
	  		post :search_bookings, :booking => {:booking_code => reservation.booking_code}
	  		booking = assigns(:booking)
	  		expect(booking.booking_code).to eql(reservation.booking_code)
	  	end

	  	it 'updates the passenger' do
	  		post :search_bookings, :booking => {:booking_code => reservation.booking_code}
	  		booking = assigns(:booking)
	  		new_booking[:flight_id] = 30
	  		new_booking[:booking_code] = booking.booking_code
	  		new_booking[:price] = booking.price
	  		new_booking[:id] = booking.id
	  		new_booking[:passengers_attributes] = [{:first_name => "Benevolent",
	  																					:last_name => "Peters",
	  																					:email => "Konga@gmail.com", :id => 1,
	  																					:booking_id => booking.id}]
	  		post :update, :booking => new_booking
	  		expect(response).to redirect_to(manage_booking_path)
	  		passenger = Passenger.find_by(:id => 1)
	  		expect(passenger.first_name).to eql("Benevolent")
	  		expect(Passenger.all.size).to eql(2)
	  	end
	  end
	end
end
