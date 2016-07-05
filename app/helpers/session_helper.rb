module SessionHelper
	def logged_in?
		return false unless session[:user_id].present?
		true
	end
end
