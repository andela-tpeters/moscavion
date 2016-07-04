class Booking < ActiveRecord::Base
	belongs_to :flight
	belongs_to :user
	validates  :price, :booking_code, :numericality => true, :allow_nil => false
	validates :flight, :user, :allow_nil => false, :presence => true
end
