class Airport < ActiveRecord::Base
	validates :name, :city, :country, :latitude, :longitude,
						:presence => true, :allow_nill => false
end
