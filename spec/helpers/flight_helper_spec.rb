require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FlightHelper. For example:
#
# describe FlightHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
