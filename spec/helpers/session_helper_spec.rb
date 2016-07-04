require 'rails_helper'

RSpec.describe SessionHelper, type: :helper do
	describe "#logged_in" do
		it "returns false for logged in user" do
			expect(logged_in?).to be_falsey  
		end
	end

	describe "#check_session" do
		it "returns flash[:session_error]" do
			expect(check_session).to eql("Please login to continue")  
		end
	end
end