Rails.application.routes.draw do
  root 'landing#index'

  scope controller: :landing do
  end

  scope controller: :flight do
    get "/search" => :search
  end

  scope "user", controller: :user do
    post "/login" => :login
    post "/signup" => :signup
    get "/logout" => :logout
    
    scope "booking", controller: :booking do
      get "/book/:flight_id" => :create, as: :booking_page
      post "/new" => :new, as: :new_booking
      get "/index" => :past_bookings, as: :your_bookings
      get "/manage" => :manage, as: :manage_booking
      patch "/update" => :update
      delete "/delete/:id" => :delete, as: :delete_booking
    end
  end
end
