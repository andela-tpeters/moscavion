class Flight < ActiveRecord::Base
  belongs_to :airport
  belongs_to :airline
  has_many 	:bookings
  validates :departure_location,
            :arrival_location,
            :departure_date,
            :arrival_date,
            presence: true,
            allow_blank: false

  validates :price,
            :flight_number,
            presence: true,
            numericality: true,
            allow_blank: false

  scope :departures, -> {
    select(:departure_location)
    .distinct(:departure_location)
    .where("departure_date >= ?", Time.now)
    .order(departure_location: "asc")
  }

  scope :arrivals, -> {
    select(:arrival_location)
    .distinct(:departure_location)
    .where("departure_date >= ?", Time.now)
    .order(arrival_location: "asc")
  }

  scope :all_routes, -> {
    {
      departures: departures,
      arrivals: arrivals
    }
  }

  scope :routes_to_s, -> {
    where("departure_date >= ?", Time.now)
    .order(departure_date: "asc")
    .map do |flight|
    ["#{flight.departure_location} to #{flight.arrival_location}",
      flight.id
    ]
    end
  }

  scope :search, -> (params) {
    if params.blank?
      where("departure_date > ?", Time.now)
    else
      where(params).where("departure_date > ?", Time.now)
    end
  }
end
