FactoryGirl.define do
  factory :flight do
    id 1
    departure_location "Lagos"
    arrival_location "Kaduna"
    departure_date Faker::Time.between(2.days.from_now, 5.days.from_now, :all)
    arrival_date "2016-06-18 09:00:00"
    airport
    airline
    price 250_000.50
    flight_number 1
  end
end
