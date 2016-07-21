class BookingMailer < ApplicationMailer
	default from: "no-reply@moscavion.com"

	def successful_booking(booking, user)
    @booking = booking
    @user = user
    @flight = booking.flight
    mail(to: @user.email, subject: "Successful Booking")
  end
end
