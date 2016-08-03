require "rails_helper"

RSpec.describe UserHelper, type: :helper do
  context "when there is a new sign up" do
    it "returns new object" do
      expect(new_user.new_record?).to be_truthy
    end
  end
end
