require 'rails_helper'

RSpec.feature "IndexPages", type: :feature do
	describe "#index" do
		before { visit root_path }

		it 'should not be blank' do
			expect(page).blank? == false
		end

		it 'should have Moscavion' do
			expect(page).to have_content "Moscavion"
		end

		it 'should have links' do
			within ".ui.secondary.pointing.menu" do
				expect(page.has_link? "Contact Us").to be_truthy
				expect(page.has_link? "About Us").to be_truthy
				expect(page.has_link? "Help").to be_truthy
			end
		end

		it "should have flight search form" do
			expect(page).to have_selector "form#flights_search_form"
			
			within('#flights_search_form_cont') do
				search_form = page.find("#flights_search_form")
				expect(search_form.tag_name == "form").to be_truthy
				within search_form do
					expect(page.has_field? "from").to be_truthy
					expect(page.has_field? "to").to be_truthy
					expect(page.has_field? "passengers").to be_truthy
					expect(page.has_field? "departure_date").to be_truthy
					expect(page.has_button?("Search Flight")).to be_truthy
				end
			end
		end
	end
end
