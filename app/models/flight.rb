class Flight < ActiveRecord::Base
	belongs_to :airport
	validates :departure_location,
						:arrival_location,
						:presence => true, :allow_nil => false, :string => true

	validates :departure_date, :arrival_date,
						:presence => true, :allow_nil => false
						
	validates :price, :airport_id, :flight_number, :airline_id,
						:presence => true, :numericality => true, :allow_nil => false
end
