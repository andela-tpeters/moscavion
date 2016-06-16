require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
	describe "Home Page" do
		before { visit root_path }
		it "should have Moscavion" do
			expect(page).to have_content "Moscavion"
		end
	end
end
