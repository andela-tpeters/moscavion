require "rails_helper"

RSpec.describe Passenger, type: :model do
  describe "belongs_to" do
    it { should belong_to(:booking) }
  end

  describe "validates" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should allow_value("john@doe.com").for(:email) }
  end
end
