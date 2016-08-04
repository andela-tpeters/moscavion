class FlightController < ApplicationController
  def search
    if prune_params[:departure_location] == prune_params[:arrival_location]
      render json: "Flight departure and arrival location cant be the same"
      return
    end
    render json: Flight.search(prune_params)
  end

  private

  def search_params
    params.require(:query).permit(:departure_location,
                                  :arrival_location,
                                  :departure_date)
  end

  def prune_params
    return search_params if search_params.blank?
    search_params.delete_if do |_key, value|
      value.blank?
    end
  end
end
