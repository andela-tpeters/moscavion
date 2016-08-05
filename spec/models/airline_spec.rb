require "rails_helper"

RSpec.describe Airline, type: :model do
  describe "belong_to" do
    it { expect(subject).to belong_to(:airport) }
  end

  describe "has_many" do
    it { expect(subject).to have_many(:flights) }
  end
end
