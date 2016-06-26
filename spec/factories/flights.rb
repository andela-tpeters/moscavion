FactoryGirl.define do
  factory :flight do
    from "Lagos"
    to "Kaduna"
    departure_date "2016-06-17 09:00:00"
    airports_id 1
  end
end
