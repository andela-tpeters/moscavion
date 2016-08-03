require "rails_helper"

RSpec.describe Airport, type: :model do
  describe "has_many" do
    it { should have_many(:flights) }
    it { should have_many(:airlines) }
  end

  describe "validates" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:latitude) }
    it { should validate_numericality_of(:latitude) }
    it { should validate_numericality_of(:longitude) }
  end
end
