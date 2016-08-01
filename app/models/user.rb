class User < ActiveRecord::Base
  has_many :bookings
  has_secure_password

  validates :first_name,
            :last_name,
            presence: true,
            allow_nil: false

  validates :email,
            presence: true,
            format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
            allow_nil: false,
            uniqueness: true

  validates :password,
            presence: true,
            confirmation: true,
            allow_nil: false,
            length: { minimum: 6 }

end
