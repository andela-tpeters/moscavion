require 'rails_helper'
include SessionHelper

RSpec.describe UserController, type: :controller do
	render_views
	let(:user) { {:email => "peters@gmail.com", :password => "p@$$w0rd"} }

	before do
		load "#{Rails.root}/spec/support/seed.rb"
		Seed.users
	end

	def post_login
		request.env["HTTP_REFERER"] = "where_i_am_coming_from"
		post :login, :user_details => user
	end

	before(:all) do
		post_login
	end

	describe '#login_params' do
	  it "returns user_details" do
	  	post_login
	  	expect(controller.send(:login_params)["email"]).to be(user[:email])
	  end
	end

	describe "login" do
		context 'when user provide correct details' do
			it 'saves sets a session for the user' do
				post_login
				id = session[:user_id]
				expect(id).to eql(1)
				expect(User.find_by(:id => id).email).to eql(user[:email])
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
				expect(logged_in?).to be_truthy
			end
		end

		context 'when user details are incorrect' do
			it 'returns an error' do
				user["password"] = ""
				post_login
				expect(session["flash"]["flashes"]["error"])
							.to eql("Your email or password is not correct")
				expect(response).to redirect_to(login_page_path)
			end
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
		  get :login_page
		  expect(response).to render_template('login_page')
		  expect(response.body).to include('Login')
		end
	end
end
