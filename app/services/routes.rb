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
      req.flash[:errors] = "Flight has departed"
      return true
    end
    false
  end

  def self.flight_exist?(req, flight_id)
    if Flight.find_by(id: flight_id).nil?
      req.flash[:errors] = "Flight does not exist"
      return false
    end
    true
  end
end
