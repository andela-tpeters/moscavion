class LandingController < ApplicationController
  def index
    render locals: Flight.all_routes
  end
end
