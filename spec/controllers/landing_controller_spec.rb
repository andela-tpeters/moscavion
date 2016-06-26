require 'rails_helper'

RSpec.describe LandingController, type: :controller do
	render_views
	describe 'GET Index Page' do

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

	describe "GET signup page" do
		it 'routes to the signup page' do
			get :signup
			expect(response).to render_template("signup")
			expect(response.body).to include("Register")
			expect(response.body).to include("signup-form")
		end
	end

	describe 'GET login' do
		it 'routes to the login page' do
		  get :login
		  expect(response).to render_template('login')
		  expect(response.body).to include('Login')
		end
	end
end
