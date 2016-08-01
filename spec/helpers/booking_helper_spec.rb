require 'rails_helper'

RSpec.describe BookingHelper, type: :helper do
  let(:user) { create :user }

  context 'when past user bookings empty' do
    it 'should print No bookings yet' do
      expect(display_bookings user.bookings)
              .to include("No Bookings yet!")
      expect(class_for_bookings user.bookings).to eql("header centered")
    end
  end

  context 'when user has past bookings' do
    it 'should render' do
      booking = create :booking
      user = booking.user
      expect(display_bookings user.bookings)
            .to include(booking.booking_code)
      expect(class_for_bookings user.bookings).to eql("cards")
    end
  end

  context 'when there is old email' do
    it 'prints the old email' do
      email = {send_email: Faker::Internet.email}
      expect(old_email email).to eql(email[:send_email])
    end
  end

  context 'when flight has departed' do
    it 'return disabled' do
      flight = create :flight, departure_date: Faker::Time.backward(1)
      booking = create :booking, flight: flight
      expect(disable_edit booking).to eql("disabled")
    end
  end
end
