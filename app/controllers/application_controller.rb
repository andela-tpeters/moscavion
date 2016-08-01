class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def check_session
		if current_user.nil?
			flash[:errors] = "Please login to continue"
			redirect_to root_path and return
		end
	end

	def errors
		flash[:errors]
	end

  def logged_in?
    current_user.present?
  end

  def current_user
    User.find_by_id(session[:user_id])
  end
end
