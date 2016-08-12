class Seed
  def self.airports
    File.open("./db/airports.dat", "r") do |file|
      300.times do
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
      end
    end
  end

  def self.airlines
    File.open("./db/airlines.dat", "r") do |file|
      100.times do
        offset = rand(Airport.count)
        line_content = file.readline.shellsplit[0].split(",")
        airline_data = {
          name: line_content[1],
          iata: line_content[3],
          icao: line_content[4],
          airport: Airport.offset(offset).first
        }
        Airline.create(airline_data)
      end
    end
  end

  def self.flights
    File.open("./db/routes.dat", "r") do |file|
      (1..200).each do |number|
        line_content = file.readline.shellsplit[0].split(",")
        arrival_id = 301 - number
        _depart_airport = Airport.find_by(id: line_content[3])
        _arrival_airport = Airport.find_by(id: line_content[5])
        airline_offset = rand(Airline.count)
        ddate = Faker::Time.between(2.days.ago, 7.days.from_now, :all)
        flight_data = {
          departure_date: ddate,
          arrival_date: Faker::Time.between(ddate, (ddate + 3.days), :all),
          airport: Airport.find_by(id: number),
          airline: Airline.offset(airline_offset).first,
          flight_number: Faker::Number.number(6),
          departure_location: Airport.find_by(id: number).name,
          arrival_location: Airport.find_by(id: arrival_id).name,
          price: Faker::Commerce.price
        }
        Flight.create(flight_data)
      end
    end
  end

  def self.users
    email = ["peters@gmail.com", "petros@yahoo.com", "jumbos@this.com"]
    %w(peters petros jumbos).each.with_index do |name, index|
      user_data = {
        first_name: name,
        last_name: name,
        email: email[index],
        password: "p@$$w0rd",
        password_confirmation: "p@$$w0rd"
      }
      User.create(user_data)
    end
  end

  def self.all
    airports
    airlines
    flights
    users
  end
end
