class User < ActiveRecord::Base
	has_many :bookings
	include BCrypt

	validates :first_name, :last_name, :presence => true,
																		 :string => true,
																		 :length => { :in => 6..25 },
																		 :allow_nil => false

	validates :email, :presence => true,
										:format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
										:allow_nil => false

	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
		check_password new_password
		@password = Password.create new_password
		self.password_hash = @password
	end

	private

	def check_password(value)
		if value.blank? || value.length < 6
			errors.add(:password_hash, "Password must be <= 6 chars")
			raise ActiveRecord::RecordInvalid.new self
		end
	end

end
