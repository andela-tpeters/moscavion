class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionHelper

	def check_session
		if current_user.nil?
			flash[:errors] = ["Please login to continue"]
			redirect_to root_path and return
		end
	end
end
