require "rails_helper"

RSpec.feature "IndexPages", type: :feature do
  describe "#index" do
    before(:all) do
      load "#{Rails.root}/spec/support/seed.rb"
      Seed.all
    end

    scenario "should not be blank", js: true do
      visit "/"
      expect(page.blank?).to be_falsey
      expect(page).to have_content "Moscavion"
      click_on("Moscavion")
      click_on("All flight")
      page.driver.browser.navigate.refresh
      click_on("Manage")
      page.driver.browser.navigate.refresh
      click_on("Sign In")
      page.driver.browser.navigate.refresh
      click_on("Sign Up")
      page.driver.browser.navigate.refresh
    end
  end
end
