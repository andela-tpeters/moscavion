require 'rails_helper'

RSpec.feature "IndexPages", type: :feature do
  describe "#index" do
    before { visit '/' }

    it 'should not be blank' do
      expect(page).blank? == false
    end

    it 'should have Moscavion' do
      expect(page).to have_content "Moscavion"
    end
  end
end
