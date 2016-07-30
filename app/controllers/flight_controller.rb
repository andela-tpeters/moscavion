class FlightController < ApplicationController
  def search
    render json: Flight.search(prune_params)
  end

  private

  def search_params
    params.require(:query).permit(:departure_location,
                                  :arrival_location,
                                  :passengers,
                                  :departure_date )
  end

  def prune_params
    return search_params if search_params.blank?
    search_params.delete_if do |key, value|
      value.blank?
    end
  end
end
