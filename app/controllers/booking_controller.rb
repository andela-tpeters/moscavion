class BookingController < ApplicationController
	def new
	end

	private
	def booking_params
		params.require(:new_booking).permit(:email, :name, :price)
	end
end
