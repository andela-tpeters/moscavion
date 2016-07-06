require 'rails_helper'

RSpec.describe FlightController, type: :controller do
	let(:query) { {
								:departure_location => nil,
								:arrival_location => nil,
								:departure_date => nil } }

	before(:all) do
	  load "#{Rails.root}/spec/support/seed.rb" 
  	Seed.all
	end

	def visit_search
		get :search, :query => query
	end

	describe 'prune params' do
		context 'when query params are blank' do
			it 'returns blank hash' do
		  	visit_search
		  	expect(controller.send(:prune_params)).to eq({})
		  end
		end

		context 'when query params are not blank' do
			it 'return query params' do
				query[:departure_location] = "Ilorin"
				visit_search
				expect(controller.send(:prune_params)).to include("departure_location")
				expect(controller.send(:prune_params)[:departure_location]).to eql("Ilorin")
			end
		end
	end

	describe 'search method' do
		context 'when query is blank' do
			it 'returns all flights' do
		  	visit_search
		  	expect(response.content_type).to eql("application/json")
		  end
		end

	  context 'when query has nil params' do
			it 'returns all flights on nil query params' do
		  	query[:departure_location] = nil
		  	visit_search
		  	expect(response.content_type).to eql("application/json")
		  	expect(JSON.parse(response.body).length).to eql(300)
		  end	  	
	  end
	end

	describe 'flights method' do
	  context 'when query params are nil' do
	  	it 'returns 300 flights' do
	  		visit_search
	  		expect(JSON.parse(response.body).size).to eq(300)
	  	end
	  end

	  context "when query has one parameter supplied" do
	  	it 'returns search results' do
	  		query[:departure_location] = Airport.find_by(:id => 1).name
	  		visit_search
	  		result = JSON.parse(response.body)
	  		expect(result).to be_kind_of(Array)
	  		expect(result[0]["departure_location"]).to eql(query[:departure_location])
	  	end

	  	it 'returns search results' do
	  		query[:arrival_location] = Airport.find_by(:id => 50).name
	  		visit_search
	  		result = JSON.parse(response.body)
	  		expect(result).to be_kind_of(Array)
	  		expect(result[0]["arrival_location"]).to eql(query[:arrival_location])
	  	end
	  end

	  context 'when 2 parameters are provided' do
	  	it 'returns search results' do
	  		query[:departure_location] = "Nadzab"
	  		query[:arrival_location] = "Deurne"
	  		visit_search
	  		result = JSON.parse(response.body)
  			expect(result[0]["departure_location"]).to eql(query[:departure_location])
  			expect(result[0]["arrival_location"]).to eql(query[:arrival_location])
	  		expect(result).to be_kind_of(Array)
	  	end
	  end
	end
end
