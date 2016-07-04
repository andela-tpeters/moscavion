class UserController < ApplicationController
	def login
		user = User.find_by(:email => login_params[:email])
		unless user.password == login_params[:password]
			flash[:error] = "Your email or password is not correct"
			redirect_to login_page_path and return
		end
		session[:user_id] = user.id
		redirect_to request.referer and return
	end

	def login_page
	end

	def signup
	end

	private
	def login_params
		params.require(:user_details).permit(:email, :password)
	end
end
