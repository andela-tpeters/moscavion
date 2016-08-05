require "rails_helper"

RSpec.describe User, type: :model do
  describe "has_many" do
    it { expect(subject).to have_many(:bookings) }
  end

  describe "validates" do
    it { expect(subject).to validate_presence_of(:first_name) }
    it { expect(subject).to validate_presence_of(:last_name) }
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to have_secure_password }
    it { expect(subject).to allow_value("john@doe.com").for(:email) }
    it { expect(subject).to validate_length_of(:email) }
    it { expect(subject).to validate_uniqueness_of(:email) }
    it { expect(subject).to validate_confirmation_of(:password) }
  end
end
