module Custom
  class Reservation
    attr_accessor :flash

    def initialize(request, properties, current_user, email = nil)
      @properties = properties
      @user = current_user
      @errors = []
      @flash = Custom::Flash.new request
      @mail_to = email
    end

    def email
      return @user.email if @user
      @mail_to
    end

    def save
      booking = new_booking
      if booking.errors.empty?
        self.class.send_mail booking, email
      else
        @flash.errors = booking.errors.full_messages
      end
      self
    end

    def new_booking
      return @user.bookings.create @properties if @user
      Booking.create @properties
    end

    def self.create(request, properties, current_user, email = nil)
      booking = self.new(request, properties, current_user, email).save
      return properties if booking.flash.errors
      booking.flash.notice = "Booking reservation Successful"
      properties
    end

    class << self
      def bookings(user, page)
        user.bookings.order(created_at: "desc")
                      .paginate(page: page, per_page: 4)
      end

      def get_booking(criteria = {})
        Booking.find_by criteria
      end

      def find(request, criteria = {})
        booking = get_booking criteria
        return prepare_for_edit booking if booking
        Flash.new(request).errors = "Booking reservation not found"
        booking
      end

      def update(request, details, email)
        booking = get_booking booking_code: details[:booking_code]
        if booking.update details
          send_mail booking, email
          Flash.new(request).notice = "Booking Updated" and return
        end
        Flash.new(request).errors = booking.errors.full_messages and
        return unless booking.errors.empty?
      end

      def prepare_for_edit(booking)
        flight = booking.flight
        flight.price = booking.price
        {
          booking: booking,
          flights: Custom::Routes.to_s,
          flight: flight
        }
      end

      def send_mail(booking, mail_to)
        BookingMailer.successful_booking(booking, mail_to).deliver_later
      end
    end
  end
end