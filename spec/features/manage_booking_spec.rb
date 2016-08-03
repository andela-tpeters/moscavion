require "rails_helper"

RSpec.feature "Booking", type: :feature do
  feature "Manage", js: true do
    let(:booking) { create :booking }

    scenario "when flight has not departed" do
      visit "/"
      click_on "Manage"
      fill_in "booking[booking_code]", with: booking.booking_code
      click_on "Find"
      fill_in "send_email", with: Faker::Internet.email
      click_on "Confirm Info"
      click_on "OK"
      click_on "Submit"
      expect(page).to have_content "Booking Updated"
    end

    scenario "when flight has departed" do
      flight = create :flight, departure_date: Faker::Time.backward(1)
      booking = create :booking, flight: flight
      visit "/"
      click_on "Manage"
      fill_in "booking[booking_code]", with: booking.booking_code
      click_on "Find"
      expect(page).to have_content "Flight has departed"
    end
  end
end
