module SessionHelper
	def logged_in?
		return false unless session[:user_id].present?
		true
	end

	def current_user
		User.find_by(:id => session_id)
	end

	def session_id
		session[:user_id]
	end
end
