class LandingController < ApplicationController
	def index
		render locals: Custom::Routes.all_routes
	end
end
