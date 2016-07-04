module SessionHelper
	def check_session
		unless logged_in?
			flash[:session_error] = "Please login to continue"
		end
	end

	def logged_in?
		return false unless session[:user_id].present?
		true
	end
end
