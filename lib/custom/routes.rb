module Custom
	class Routes
		def self.new_booking(request, id)
			flight = Flight.find_by(id: id)
			{
				flight: flight,
				booking: flight.bookings.new(price: flight.price)
			}
		end

		def self.departed?(req, flight)
			if flight.departure_date < Time.now
				Custom::Flash.new(req).errors = "Flight has departed"
				return true
			end
			false
		end

		def self.to_s
			Flight.where("departure_date >= ?", Time.now)
								.order(departure_date: :asc)
                .map do |flight| 
                ["#{flight.departure_location} to #{flight.arrival_location}",
                  flight.id
                ]
                end
		end

		def self.departures
			Flight.select(:departure_location)
						.distinct(:departure_location)
						.where("departure_date >= ?", Time.now)
						.order(departure_location: :asc)
		end

		def self.arrivals
			Flight.select(:arrival_location)
						.distinct(:departure_location)
						.where("departure_date >= ?", Time.now)
						.order(arrival_location: :asc)
		end

		def self.all_routes
			{
				departures: self.departures,
				arrivals: self.arrivals
			}
		end

		def self.flight_exist?(req, flight_id)
			if Flight.find_by(id: flight_id).nil?
				Custom::Flash.new(req).errors = "Flight does not exist"
				return false
			end
			true
		end
	end
end