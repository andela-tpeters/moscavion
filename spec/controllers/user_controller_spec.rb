require 'rails_helper'

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
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user details are incorrect' do
      it 'returns an error' do
        user["password"] = ""
        post_login
        expect(session["flash"]["flashes"]["errors"])
              .to eql("User details cannot be empty")
        expect(response).to redirect_to(request.env["HTTP_REFERER"])
      end
    end

    context 'when user is not registered' do
      it 'returns a flash' do
        user[:email] = "bengos@b.com"
        post_login
        expect(session["flash"]["flashes"]["errors"])
                .to include("User not registered")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST signup page" do
    context 'when signup details are correct' do
      it 'creates the user and then logs the user in' do
        request.env["HTTP_REFERER"] = "where_i_am_coming_from"
        post :signup, user: { first_name: "Tijesunimi",
                              last_name: "Petros",
                              email: "tijesunimi48@gmail.com",
                              password: "petros",
                              password_confirmation: "petros"
                            }

        expect(response.body).to redirect_to(root_path)
        expect(User.last.first_name).to eql("Tijesunimi")
      end
    end

    context 'when signup details are not correct' do
      it 'does not create user and redirects to the referer witha a flash message' do
        request.env["HTTP_REFERER"] = "where_i_am_coming_from"
        post :signup, user: { first_name: "Tijesunimi",
                              last_name: "Pe",
                              email: "tijesunimi48@gmail.com",
                              password: "petros",
                              password_confirm: "petros"
                            }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'logout' do
    it 'clears session' do
      post_login
      id = session[:user_id]
      expect(id).to eql(1)

      get :logout
      expect(session[:user_id]).to be_nil
      expect(session["flash"]["flashes"]["notice"])
              .to eql("You have successfully logged out")
      expect(response).to redirect_to(root_path)
    end
  end
end
