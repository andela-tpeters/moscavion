class LandingController < ApplicationController
	def index
		@departures = Flight.select(:departure_location).distinct(:departure_location)
		@arrivals = Flight.select(:arrival_location).distinct(:arrival_location)
	end
end
