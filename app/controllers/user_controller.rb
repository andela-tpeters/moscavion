class UserController < ApplicationController
	before_action :user_blank?, only: [:login]
	before_action :check_password, only: [:signup]

	def login
		if user.nil?
			flash[:errors] = ["User not registered"]
			redirect_to root_path and return
		end
		validate_details
		flash[:notice] = "Login Successful"
		session[:user_id] = user.id
		redirect_to :back and return
	end

	def signup
		user = User.create user_params.to_a[0..-2].to_h
		unless user.errors.empty?
			flash[:errors] = user.errors.full_messages
			redirect_to :back and return
		end
		session[:user_id] = user.id
		flash[:notice] = "Signup Successful"
		redirect_to :back and return
	end

	def logout
		session.clear
		flash[:notice] = "You have successfully logged out"
		redirect_to root_path and return
	end

	private
	def login_params
		params.require(:user_details).permit(:email, :password)
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirm)
	end

	def user_blank?
		if prune_params.blank? || prune_params.size < 2
			flash[:error] = "User details cannot be empty"
			redirect_to :back and return
		end
	end

	def prune_params
		login_params.delete_if { |key, value| value.blank? }
	end

	def user
		User.find_by(:email => prune_params[:email])
	end

	def validate_details
		unless user.password == prune_params[:password]
			flash[:errors] = ["Your email or password is not correct"]
			redirect_to root_path and return
		end
	end

	def check_password
		if user_params[:password].nil? || user_params[:password] != user_params[:password_confirm]
			flash[:errors] = ["Password can't be empty/does not match"]
			redirect_to :back and return
		end
	end
end
