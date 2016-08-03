require "rails_helper"

RSpec.describe Airline, type: :model do
  describe "belong_to" do
    it { should belong_to(:airport) }
  end

  describe "has_many" do
    it { should have_many(:flights) }
  end
end
