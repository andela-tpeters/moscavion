require 'rails_helper'

RSpec.describe FlightHelper, type: :helper do
  describe 'format date' do
    it 'stringify time' do
      expect(format_date(Time.new(2016, 07, 21, 13, 14, 41)))
            .to eql("21, July 2016 @ 13:14:41")
    end
  end

  describe "icon" do
    it 'html icon with classes' do
      expect(icon("door")).to eq("<i class='door brown icon'></i>")
    end
  end

  describe 'flight row' do
    it 'returns html row tag with its content' do
      expect(flight_row("door", "Departure", "Today")).to include("Departure")
    end
  end
end
