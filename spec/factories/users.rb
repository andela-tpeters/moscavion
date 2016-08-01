FactoryGirl.define do
  factory :user do
    first_name "Tijesunimi"
    last_name "Peters"
    email "tijesunimi.peters@andela.com"
    password "password"
    password_confirmation "password"
  end
end
