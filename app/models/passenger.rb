class Passenger < ActiveRecord::Base
  belongs_to :booking
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                    presence: true

  validates :first_name, :last_name, presence: true,
                                     allow_blank: false,
                                     length: { minimum: 3 }
end
