class Airline < ActiveRecord::Base
  belongs_to :airport
  has_many :flights
end
