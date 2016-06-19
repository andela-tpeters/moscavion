class Airport < ActiveRecord::Base
	validates :name, :city, :country, :latitude, :longitude,
						:presence => true, :allow_nill => false
	validates :name, :city, :country, :string => true
	validates :latitude, :longitude, :numericality => true
end
