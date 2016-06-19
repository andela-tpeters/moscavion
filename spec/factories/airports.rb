FactoryGirl.define do
  factory :airport do
    name "Heathrow"
    city "London"
    country "United Kingdom"
    iata "LHR"
    icao "EGLL"
    latitude 51.4775
    longitude -0.461389
    tz_db "Europe/London"
  end
end

