class BookingController < ApplicationController
  before_action :check_session, :only => [:past_bookings]
  before_action :check_email, :only => [:create, :update]

  def past_bookings
    @bookings = Reservation.bookings current_user, params[:page]
  end

  def create
    booking = Reservation.create(request,
                                booking_params,
                                current_user,
                                email)
    handle_redirect booking[:flight_id], true
  end

  def new
    unless flight_exist? params[:flight_id]
      redirect_to root_path and return
    end
    data = Routes.new_booking request, params[:flight_id]
    handle_booking_redirect request, data
  end

  def manage
    booking = Reservation.find(request, search_params)
    handle_booking_redirect request, booking
  end

  def update
    Reservation.update request, booking_params, email
    booking = { booking: { booking_code: booking_params[:booking_code] } }
    handle_redirect booking
  end

  def email
    return current_user.email if current_user
    params[:send_email]
  end

  def delete
    if Booking.find_by(id: params[:id]).destroy
      flash[:notice] = "Reservation deleted Successfully"
    end
    redirect_to :back
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id,
                                    :user_id,
                                    :booking_code,
                                    :price,
                                    passengers_attributes: [
                                      :id,
                                      :first_name,
                                      :last_name,
                                      :email,
                                      :_destroy
                                      ]
                                  )
  end

  def search_params
    params.require(:booking).permit(:booking_code)
  end

  def check_email
    flash[:errors] = "Pls provide recevier email" unless email
  end

  def handle_redirect(pay_load, flag=false)
    if errors && flag
      redirect_to booking_page_path(pay_load) and return
    elsif errors && !flag
      redirect_to manage_booking_path(pay_load) and return
    elsif current_user
      redirect_to your_bookings_path and return
    else
      redirect_to root_path
    end
  end

  def flight_exist?(flight_id)
    Routes.flight_exist? request, flight_id
  end

  def handle_booking_redirect(req, booking)
    redirect_to root_path and return if booking.nil?
    if Routes.departed?(req, booking[:flight])
      redirect_to root_path and return
    end
    render locals: booking
  end
end
