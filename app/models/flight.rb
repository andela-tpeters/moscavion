class Flight < ActiveRecord::Base
  belongs_to :airport
  belongs_to :airline
  has_many 	:bookings
  validates :departure_location,
            :arrival_location,
            presence: true, allow_blank: false, string: true

  validates :departure_date, :arrival_date,
            presence: true, allow_blank: false

  validates :price, :flight_number,
            presence: true, numericality: true, allow_blank: false
end
