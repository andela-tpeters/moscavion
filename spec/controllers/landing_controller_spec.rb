require 'rails_helper'

RSpec.describe LandingController, type: :controller do
	describe 'GET Index Page' do
		render_views

		before(:each) do
		  get :index
		end

	  it 'route to the index page' do
	  	expect(response).to render_template("index")
	  end

	  it 'displays the right content' do
	  	expect(response.body).to include("Moscavion")
	  	expect(response.body).to include("flights_search_form")
	  end
	end
end
