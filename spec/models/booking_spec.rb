require "rails_helper"

RSpec.describe Booking, type: :model do
  describe "belong_to" do
    it { expect(subject).to belong_to(:flight) }
    it { expect(subject).to belong_to(:user) }
  end

  describe "has_many" do
    it { expect(subject).to have_many(:passengers) }
  end

  describe "validate" do
    it { expect(subject).to validate_presence_of(:passengers) }
    it { expect(subject).to validate_presence_of(:flight) }
    it { expect(subject).to accept_nested_attributes_for(:passengers) }
  end
end
