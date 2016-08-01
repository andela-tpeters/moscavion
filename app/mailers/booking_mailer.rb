class BookingMailer < ApplicationMailer
	default from: "no-reply@moscavion.com"

	def successful_booking(booking, mail_to)
    @booking = booking
    @flight = booking.flight
    mail(to: mail_to, subject: "Successful Booking")
  end
end
