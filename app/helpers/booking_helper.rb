module BookingHelper
  def disable_edit(booking)
    if booking.flight.departure_date < Time.now
      "disabled"
    end
  end

  def display_bookings(bookings)
    if bookings.empty?
      "<h1 class='ui header centered'>No Bookings yet!</h1>".html_safe
    else
      render partial: "partials/booking_item", collection: bookings, as: :item
    end
  end

  def class_for_bookings(bookings)
    if bookings.empty?
      "header centered"
    else
      "cards"
    end
  end

  def old_email(params)
    params[:send_email]
  end
end
