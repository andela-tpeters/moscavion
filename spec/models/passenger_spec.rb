require "rails_helper"

RSpec.describe Passenger, type: :model do
  describe "belongs_to" do
    it { expect(subject).to belong_to(:booking) }
  end

  describe "validates" do
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_presence_of(:first_name) }
    it { expect(subject).to validate_presence_of(:last_name) }
    it { expect(subject).to allow_value("john@doe.com").for(:email) }
  end
end
