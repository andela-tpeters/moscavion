class Booking < ActiveRecord::Base
	before_create :set_code
	belongs_to :flight
	belongs_to :user
	has_many :passengers
	validates  :price, :numericality => true, :allow_nil => false
	validates :flight, :user, :allow_nil => false, :presence => true
	accepts_nested_attributes_for :passengers, :reject_if => :all_blank,
																							:allow_destroy => true

	private
	def set_code
		raw = [('A'..'Z'),(0..9)].map { |i| i.to_a }.flatten
    self.booking_code = (0...10).map { raw[rand(raw.length)] }.join
	end
end
