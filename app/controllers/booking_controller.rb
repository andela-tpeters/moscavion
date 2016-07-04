class BookingController < ApplicationController
	# before_action :index,

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
end
