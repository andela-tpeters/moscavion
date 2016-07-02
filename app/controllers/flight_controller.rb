class FlightController < ApplicationController
	def search
		render :json => flights
	end

	private

	# def search_params
	# end

	def prune_params
		return params[:query] if params[:query].blank?
		params[:query].delete_if do |key, value|
			value.blank?
		end
		params[:query]
	end

	def flights
		if prune_params.blank?
			Flight.all
		else
			Flight.find_by(prune_params)
		end
	end
end
