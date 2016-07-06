class BookingController < ApplicationController
	before_action :check_session, :only => [:index]

	def index
		@bookings = current_user.bookings
	end

	def new
		booking = create_booking
		unless booking.errors.empty?
			flash[:errors] = booking.errors.messages
			redirect_to :back and return
		end
		flash[:notice] = "Booking Successful"
		redirect_to your_bookings_path and return if logged_in?
		redirect_to root_path
	end

	def manage
		# @booking = Booking.find_by(manage_params)
	end

	def search_bookings
		@booking = Booking.find_by(search_params)
		@passengers = @booking.passengers
	end

	def update
		@booking.update(booking_params)
		redirect_to manage_booking_path
	end

	private
	def booking_params
		params.require(:booking).permit(:flight_id, :user_id,
																				:price,
																				passengers_attributes: [:id, :first_name, :last_name, :email])
	end

	def create_booking
		if logged_in? && current_user
			current_user.bookings.create booking_params
		else
			Booking.create booking_params
		end
	end

	def search_params
		params.require(:booking).permit(:booking_code)
	end
end
