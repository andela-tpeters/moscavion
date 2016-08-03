FactoryGirl.define do
  factory :booking do
    user
    price 25_000.00
    flight
    passengers_attributes [{ first_name: "Petros", last_name: "Petros",
                             email: "petros@petros.com" }]
  end
end
