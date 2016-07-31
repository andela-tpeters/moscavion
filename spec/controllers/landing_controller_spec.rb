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
    end
  end
end
