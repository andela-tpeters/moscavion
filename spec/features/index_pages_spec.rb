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
			expect(page.has_link? "Contact Us").to be_truthy
		end
	end
end
