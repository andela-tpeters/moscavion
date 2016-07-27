module ApplicationHelper
	def notice
		render partial: "layouts/notice_message"
	end

	def error_msg
		render partial: "layouts/error_message_display"
	end

	def login_msg
		render partial: "layouts/login_msg"
	end

	def disable_profile_link
		if session[:user_id].nil?
			"ui button basic disabled"
		else
			"ui button basic"
		end
	end
end
