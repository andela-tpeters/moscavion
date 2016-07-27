module SessionHelper
	def logged_in?
		current_user.present?
		# return false unless session[:user_id].present?
		# return false unless session[:user_id].present?
		# true
	end

	def current_user
		User.find_by_id(session_id)
		# User.find_by(:id => session_id)
	end

	def session_id
		session[:user_id]
	end
end
