require 'rails_helper'

RSpec.describe FlightController, type: :controller do
	let(:query) { {} }

	before(:all) do
	  load "#{Rails.root}/spec/support/seed.rb" 
  	Seed.all
	end

	def visit
		get :search, :query => query
	end

	describe 'prune params' do
		context 'when query params are blank' do
			it 'returns blank hash' do
		  	query[:departure_location] = nil
		  	visit
		  	expect(controller.send(:prune_params)).to eq({})
		  end
		end

		context 'when query params are not blank' do
			it 'return query params' do
				query[:departure_location] = "Ilorin"
				visit
				expect(controller.send(:prune_params)).to include("departure_location")
				expect(controller.send(:prune_params)[:departure_location]).to eql("Ilorin")
			end
		end
	end

	describe 'search method' do
		context 'when query is blank' do
			it 'returns all flights' do
		  	visit
		  	expect(response.content_type).to eql("application/json")
		  end
		end

	  context 'when query has nil params' do
			it 'returns all flights on nil query params' do
		  	query[:departure_location] = nil
		  	visit
		  	expect(response.content_type).to eql("application/json")
		  	expect(JSON.parse(response.body).length).to eql(300)
		  end	  	
	  end
	end

	describe 'flights method' do
	  context 'when query is blank' do
	  	it 'returns 300 flights' do
	  		visit
	  		expect(JSON.parse(response.body).size).to eq(300)
	  	end
	  end

	end
end
