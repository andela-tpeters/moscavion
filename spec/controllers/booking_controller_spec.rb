require "rails_helper"

RSpec.describe BookingController, type: :controller do
  let(:new_booking) do
    {
      flight_id: Flight.first.id,
      price: Faker::Commerce.price,
      passengers_attributes: [{ first_name: "Tijesunimi",
                                last_name: "Peters",
                                email: "tijesunimi@gmail.com" }]
    }
  end

  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.all
  end

  def post_new
    request.env["HTTP_REFERER"] = "new_booking_path"
    post :create, booking: new_booking, send_email: "tijesunimi@gmail.com"
  end

  describe "session" do
    context "when a user is not logged in" do
      it "should return false logged_in?" do
        post_new
        expect(controller.send(:logged_in?)).to be_falsey
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#new" do
    before do
      session[:user_id] = 1
    end

    context "when user fills form new booking" do
      it "should save booking and redirect to your_bookings_path" do
        post_new
        expect(response).to redirect_to(your_bookings_path)
        flight = Flight.find_by id: new_booking[:flight_id]
        expect(Booking.find_by(flight_id: 1).flight).to eql(flight)
      end
    end

    context "when user enters empty data" do
      it "raise error" do
        new_booking.clear
        expect { post_new }.to raise_error ActionController::ParameterMissing
      end
    end
  end

  describe "user bookings" do
    before do
      user_ids = [1, 2, 1, 3, 4, 2, 3, 2, 1, 1]
      user_ids.each do |id|
        session[:user_id] = id
        new_booking[:flight_id] = Flight.offset(rand(Flight.count)).first
        new_booking[:user_id] = User.find_by(id: id)
        post_new
      end
    end

    context "when user has made bookings" do
      it "returns bookings perculiar to the user 1" do
        get :past_bookings
        expect(assigns(:bookings).size).to eql(4)
      end

      it "returns bookings for user 2" do
        session[:user_id] = 2
        get :past_bookings
        expect(assigns(:bookings).size).to eql(3)
      end

      it "returns nothing for user 4" do
        session[:user_id] = 4
        get :past_bookings
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "booking <> passengers" do
    it "saves passenger for booking" do
      session[:user_id] = 1
      new_booking[:passengers_attributes] = [{ first_name: "Tijesunimi",
                                               last_name: "Peters",
                                               email: "tijesunimi@gmail.com" }]
      post_new
      passenger = Passenger.find_by(booking_id: 1)
      expect(passenger.first_name).to eql("Tijesunimi")
    end

    it "does not save passenger for booking" do
      session[:user_id] = 1
      new_booking[:passengers_attributes] = []
      post_new
      expect(Passenger.all.size).to eql(0)
    end

    context "when flight id does not exist" do
      it "redirect_to root_path" do
        get :new, flight_id: 50_000
        expect(response).to redirect_to(root_path)
        expect(session["flash"]["flashes"]["errors"]).
          to include("Flight does not exist")
      end
    end

    context "when flight exists" do
      render_views
      it "renders create page" do
        flight = Flight.where("departure_date >= ?", Time.now).first
        get :new, flight_id: flight.id
        expect(response).to render_template(:new)
        expect(response.body).to include(flight.departure_location)
      end
    end
  end

  describe "manage" do
    before do
      new_booking[:flight_id] = Flight.offset(rand(Flight.count)).first
      new_booking[:passengers_attributes] = [{ first_name: "Kongas",
                                               last_name: "Peters",
                                               email: "Konga@gmail.com" },
                                             { first_name: "Bongos",
                                               last_name: "Blueking",
                                               email: "bongos@gmail.com" }]
      post_new
    end

    context "when user inputs booking code" do
      let(:reservation) { Booking.last }

      it "flashes error on invalid booking code" do
        get :manage, booking: { booking_code: "12h2y3us" }
        expect(session["flash"]["flashes"]["errors"]).
          to include("Booking reservation not found")
        expect(response).to redirect_to(root_path)
      end

      it "shows error for invalid passenger info" do
        new_booking[:passengers_attributes] << {
          first_name: "Kongas",
          last_name: "Peters",
          email: "Kongagmail.com"
        }

        new_booking[:id] = reservation.id
        new_booking[:flight_id] = reservation.flight_id
        new_booking[:booking_code] = reservation.booking_code
        post :update, booking: new_booking, send_email: Faker::Internet.email
        expect(session["flash"]["flashes"]["errors"]).
          to include("Passengers email is invalid")
      end
    end
  end

  describe "delete" do
    it "destroys booking from the database" do
      post_new
      expect(Booking.all.size).to eql(1)

      delete :delete, id: 1
      expect(Booking.all.size).to eql(0)
    end
  end
end
