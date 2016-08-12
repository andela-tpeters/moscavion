require "rails_helper"

RSpec.feature "Sign Up", type: :feature do
  feature "User signs up", js: true do
    scenario "with correct information" do
      visit "/"
      click_on "Sign Up"
      fill_in "user[first_name]", with: "John"
      fill_in "user[last_name]", with: "Doe"
      fill_in "user[email]", with: "john@doe.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_on "Submit"
      sleep 1.5
      expect(page).to have_content "Signup Successful"
    end
  end
end
