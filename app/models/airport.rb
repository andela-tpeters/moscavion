class Airport < ActiveRecord::Base
  has_many :flights, -> { distinct }
  has_many :airlines, -> { distinct }

  validates :name,
            :city,
            :country,
            :latitude,
            :longitude,
            presence: true,
            allow_nill: false

  validates :latitude, :longitude, numericality: true
end
