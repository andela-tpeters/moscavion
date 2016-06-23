class Flight < ActiveRecord::Base
	validates :departure_location,
						:arrival_location,
						:airline,
						:presence => true, :allow_nil => false, :string => true

	validates :departure_date, :arrival_date,
						:presence => true, :allow_nil => false
						
	validates :price, :airports_id, :flight_number,
						:presence => true, :numericality => true, :allow_nil => false
end
