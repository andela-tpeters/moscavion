class Booking < ActiveRecord::Base
	belongs_to :flight
	validates  :price, :booking_code, :numericality => true, :allow_nil => false
end
