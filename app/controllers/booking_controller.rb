class BookingController < ApplicationController
	before_action :check_session

	def index
		@bookings = current_user.bookings
	end

	def new
		booking = current_user.bookings.create(booking_params)
		unless booking.errors.empty?
			flash[:errors] = booking.errors.messages
			redirect_to :back and return
		end
		flash[:notice] = "Booking Successful"
		redirect_to your_bookings_path
	end

	private
	def booking_params
		params.require(:new_booking).permit(:flight_id, :user_id,
																				:price,
																				passengers_attributes: [:first_name, :last_name, :email])
	end
end
