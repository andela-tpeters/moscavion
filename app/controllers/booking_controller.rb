class BookingController < ApplicationController
  before_action :check_session, :only => [:past_bookings]

  def past_bookings
    @bookings = current_user.bookings
                            .order(created_at: "desc")
                            .paginate(page: params[:page], per_page: 4)
  end

  def new
    booking = create_booking
    unless booking.errors.empty?
      flash[:errors] = booking.errors.full_messages
      redirect_to :back and return
    end
    flash[:notice] = "Booking Successful"
    send_mail booking
  end

  def create
    @flight = Flight.find_by(:id => params[:flight_id])
    @booking = @flight.bookings.new({:price => @flight.price})
  end

  def manage
    if booking.nil?
      flash[:errors] = ["Booking reservation not found"]
      redirect_to :back and return
    end
    @booking = booking
    @flights = flights_route
    @flight = @booking.flight
    @flight.price = @booking.price
  end

  def update
    if booking.update(booking_params)
      send_mail booking
      flash[:notice] = "Booking Updated Successfully"
    end
    redirect_to :back
  end

  def delete
    if Booking.find_by(id: params[:id]).destroy
      flash[:notice] = "Reservation deleted Successfully"
    end
    redirect_to :back
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id, :user_id, :booking_code,
                                    :price, passengers_attributes: [
                                      :id, :first_name, :last_name,
                                      :email, :_destroy])
  end

  def booking
    Booking.find_by(search_params)
  end

  def create_booking
    if logged_in? && current_user
      current_user.bookings.create booking_params
    else
      Booking.create booking_params
    end
  end

  def send_mail(booking)
    if logged_in? && current_user
      BookingMailer.successful_booking(booking, current_user).deliver_later
      redirect_to your_bookings_path and return
    else
      booking.passengers.each do |p|
        BookingMailer.successful_booking(booking, p).deliver_later
      end
      redirect_to root_path and return
    end
  end

  def search_params
    params.require(:booking).permit(:booking_code)
  end

  def flights_route
    Flight.where("departure_date >= ?", Time.now).order(departure_date: :asc)
                .map do |flight| 
                ["#{flight.departure_location} to #{flight.arrival_location}",
                  flight.id
                ]
                end
  end
end
