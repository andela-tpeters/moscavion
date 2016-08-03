require "rails_helper"

RSpec.feature "Sign In", type: :feature do
  feature "User Logs in" do
    let(:user) { create :user }

    scenario "with correct details", js: true do
      visit "/"
      click_on "Sign In"
      fill_in "user_details[email]", with: user.email
      fill_in "user_details[password]", with: user.password
      click_on "Login"
      expect(page).to have_content "Login Successful"
    end

    scenario "with incorrect details", js: true do
      visit "/"
      click_on "Sign In"
      fill_in "user_details[email]", with: user.email
      fill_in "user_details[password]", with: "Blayne"
      click_on "Login"
      expect(page).to have_content "User email or password incorrect"
    end
  end

  feature "User logs in" do
    scenario "when user is not registered", js: true do
      visit "/"
      click_on "Sign In"
      fill_in "user_details[email]", with: "Banjo@gmail.com"
      fill_in "user_details[password]", with: "Blayne"
      click_on "Login"
      expect(page).to have_content "User not registered"
    end
  end
end
