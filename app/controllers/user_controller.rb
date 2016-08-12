class UserController < ApplicationController
  before_action :user_blank?, only: [:login]

  def login
    MoscavionUser.new(request, login_params, :login)
    redirect_to root_path
  end

  def signup
    MoscavionUser.new(request, user_params, :signup)
    redirect_to root_path
  end

  def logout
    session.clear
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end

  private

  def login_params
    params.require(:user_details).permit(:email, :password)
  end

  def user_params
    params.require(:user).permit(
                                 :first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation
                                )
  end

  def user_blank?
    if prune_params.blank? || prune_params.size < 2
      flash[:errors] = "User details cannot be empty"
      redirect_to :back
      return
    end
  end

  def prune_params
    login_params.delete_if { |_key, value| value.blank? }
  end
end
