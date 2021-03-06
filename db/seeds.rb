File.open("./db/airports.dat", "r") do |file|
  1000.times do
    # file.each_line do |line|
    line_content = file.readline.shellsplit[0].split(",")
    airport_data = {
      name: line_content[1],
      city: line_content[2],
      country: line_content[3],
      iata: line_content[4],
      icao: line_content[5],
      latitude: line_content[6],
      longitude: line_content[7],
      tz_db: line_content[11]
    }
    Airport.create(airport_data)
    # end
  end
end

File.open("./db/airlines.dat", "r") do |file|
  1000.times do
    line_content = file.readline.shellsplit[0].split(",")
    offset = rand(Airport.count)
    airline_data = {
      name: line_content[1],
      iata: line_content[3],
      icao: line_content[4],
      airport: Airport.offset(offset).first
    }
    Airline.create(airline_data)
  end
end

File.open("./db/routes.dat", "r") do |file|
  3000.times do
    line_content = file.readline.shellsplit[0].split(",")
    offset = rand(Airport.count)
    _depart_airport = Airport.find_by(id: line_content[3])
    _arrival_airport = Airport.find_by(id: line_content[5])
    airline_offset = rand(Airline.count)
    ddate = Faker::Time.between(2.days.ago, 7.days.from_now, :all)
    flight_data = {
      departure_date: ddate,
      arrival_date: Faker::Time.between(ddate, (ddate + 3.days), :all),
      airport: Airport.offset(offset).first,
      airline: Airline.offset(airline_offset).first,
      flight_number: Faker::Number.number(6),
      departure_location: Airport.offset(offset).first.name,
      arrival_location: Airport.offset(offset).last.name,
      price: Faker::Commerce.price
    }
    Flight.create(flight_data)
  end
end
