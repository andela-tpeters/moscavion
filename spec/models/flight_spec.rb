require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe "belongs_to" do
    it { should belong_to(:airport) }
    it { should belong_to(:airline) }
  end

  describe 'has_many' do
    it { should have_many(:bookings) }
  end

  describe 'validates' do
    it { should validate_presence_of(:departure_location) }
    it { should validate_presence_of(:departure_date) }
    it { should validate_presence_of(:arrival_location) }
    it { should validate_presence_of(:arrival_date) }
    it { should validate_presence_of(:flight_number) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
    it { should validate_numericality_of(:flight_number) }
  end

  describe '#scopes' do
    it 'respond to departures' do
      expect(Flight).to respond_to(:departures)
    end

    it 'respond to arrivals' do
      expect(Flight).to respond_to(:arrivals)
    end

    it 'responds to all_routes' do
      expect(Flight).to respond_to(:all_routes)
    end

    it 'responds to routes_to_s' do
      expect(Flight).to respond_to(:routes_to_s)
    end

    it 'responds to search' do
      expect(Flight).to respond_to(:search)
    end
  end
end
