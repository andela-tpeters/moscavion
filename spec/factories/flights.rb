FactoryGirl.define do
  factory :flight do
    departure_location "Lagos"
    arrival_location "Kaduna"
    departure_date "2016-06-17 09:00:00"
    arrival_date "2016-06-18 09:00:00"
    airports_id 1
    airline 'Sosoliso Airline'
    price 250000.50
    flight_number 1
  end
end
