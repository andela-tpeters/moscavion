require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'belong_to' do
    it { should belong_to(:flight) }
    it { should belong_to(:user) }
  end

  describe 'has_many' do
    it { should have_many(:passengers) }
  end

  describe 'validate' do
    it { should validate_presence_of(:passengers) }
    it { should validate_presence_of(:flight) }
    it { should accept_nested_attributes_for(:passengers) }
  end
end
