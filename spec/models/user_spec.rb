require "rails_helper"

RSpec.describe User, type: :model do
  describe "has_many" do
    it { should have_many(:bookings) }
  end

  describe "validates" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should have_secure_password }
    it { should allow_value("john@doe.com").for(:email) }
    it { should validate_length_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password) }
  end
end
