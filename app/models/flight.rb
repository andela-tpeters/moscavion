class Flight < ActiveRecord::Base
  belongs_to :airport
  belongs_to :airline
  has_many  :bookings
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

  def self.departures
    select(:departure_location).
      distinct(:departure_location).
      order(departure_location: "asc")
  end

  def self.arrivals
    select(:arrival_location).
      distinct(:departure_location).
      order(arrival_location: "asc")
  end

  def self.all_routes
    {
      departures: departures,
      arrivals: arrivals
    }
  end

  def self.routes_to_s
    where("departure_date >= ?", Time.now).
      order(departure_date: "asc").
      map do |flight|
        ["#{flight.departure_location} to #{flight.arrival_location}",
         flight.id]
      end
  end

  def self.search(params)
    if params.blank?
      where("departure_date > ?", Time.now)
    else
      where(params).where("departure_date > ?", Time.now)
    end
  end
end
