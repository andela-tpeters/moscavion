class Passenger < ActiveRecord::Base
	belongs_to :booking
	validates :email, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
										:presence => true,
										:allow_nil => false
	validates :first_name, :last_name, :presence => true,
													:allow_nil => false,
													:length => { :minimum => 6 }
end
