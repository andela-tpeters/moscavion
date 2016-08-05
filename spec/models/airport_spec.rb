require "rails_helper"

RSpec.describe Airport, type: :model do
  describe "has_many" do
    it { expect(subject).to have_many(:flights) }
    it { expect(subject).to have_many(:airlines) }
  end

  describe "validates" do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:city) }
    it { expect(subject).to validate_presence_of(:country) }
    it { expect(subject).to validate_presence_of(:longitude) }
    it { expect(subject).to validate_presence_of(:latitude) }
    it { expect(subject).to validate_numericality_of(:latitude) }
    it { expect(subject).to validate_numericality_of(:longitude) }
  end
end
