Rails.application.routes.draw do
  root 'landing#index'

  scope controller: :landing do
  end

  scope controller: :flight do
    get "/search" => :search
  end

  scope "user", controller: :user do
    post "/login" => :login
    get "/signup" => :signup
    get  "/login_page" => :login_page, as: :login_page
    
    scope "booking", controller: :booking do
      get "/book/:flight_id" => :create, as: :booking_page
      post "/new" => :new, as: :new_booking
      get "/index" => :index, as: :your_bookings
      get "/manage" => :manage, as: :manage_booking
      post "/search" => :search_bookings, as: :search_bookings
      post "/update" => :update
    end
  end
end
