module Custom
	class MoscavionUser

		def initialize(request, user_details = {}, action = :login)
			@errors = []
			@user_model = User
			@request = request
			@flash = Custom::Flash.new request
			send(action, user_details)
		end

		def login(user_details)
			user = get_user email: user_details[:email]
			validate_user user, user_details if user_exist? user
			if @errors.empty?
				@flash.notice = "Login Successful"
				@request.session[:user_id] = user.id and return
			else
				@flash.errors = @errors and return
			end
		end

		def signup(user_details)
			processed_details = process_details user_details
			if @errors.empty?
				user = @user_model.create processed_details
				unless user.errors.empty?
					@flash.errors = user.errors.full_messages and return
				end
				@flash.notice = "Signup Successful"
				@request.session[:user_id] = user.id
			else
				@flash.errors = @errors
			end
		end

		private

		def create_user(details)
			@user_model.create details
		end

		def get_user(criteria = {})
			user = @user_model.find_by(criteria)
		end

		def validate_user(user, details)
			user_exist? user
			validate_password user, details[:password] if @errors.empty?
		end

		def user_exist?(user)
			if user.nil?
				@errors << "User not registered" and return false
			end
			true
		end

		def validate_password(user, pwd_input)
			if pwd_input.nil? || user.password != pwd_input
				@errors << "Your email or password is not correct"
			end
		end

		def process_details(user)
			if user[:password].nil? || user[:password] != user[:password_confirm]
				@errors << "Password can't be empty/does not match" and return
			end

			user.delete :password_confirm
			user
		end
	end
end