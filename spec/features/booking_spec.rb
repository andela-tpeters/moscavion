require "rails_helper"

RSpec.feature "Booking", type: :feature do
  feature "" do
    let(:flight) { Flight.where("departure_date >= ?", Time.now).first }

    before(:all) do
      load "#{Rails.root}/spec/support/seed.rb"
      Seed.all
    end

    after(:all) { DatabaseCleaner.clean_with(:truncation) }

    scenario "when information validates", js: true do
      visit "/"
      click_on "Moscavion"
      select(flight.departure_location, from: "query[departure_location]")
      click_on("Search Flights")
      within("#flights_results") do
        all(".m-button")[0].click
      end

      fill_in "send_email", with: Faker::Internet.email
      click_on "Add Passenger"
      within ".nested-fields" do
        fill_in "First Name", with: Faker::Name.first_name
        fill_in "Last name", with: Faker::Name.last_name
        fill_in "Email", with: Faker::Internet.email
      end
      click_on "Confirm Info"

      within ".confirmation-modal" do
        click_on "OK"
      end

      click_button "Submit"
      assert_text "Booking reservation Successful"
    end
  end
end
