class BookingController < ApplicationController
	include SessionHelper
	before_action :check_session

	def new
		booking = Booking.create(booking_params)
		unless booking.errors.empty?
			flash[:errors] = booking.errors.messages
			redirect_to :back and return
		end
		flash[:notice] = "Booking Successful"
		redirect_to your_bookings_path
	end

	private

	def booking_params
		params.require(:new_booking).permit(
																				:flight_id,
																				:user_id,
																				:price,
																				:booking_code
																				)
	end

	def check_session
		unless logged_in?
			flash[:session_error] = "Please login to continue"
			redirect_to login_page_path
		end
	end
end
