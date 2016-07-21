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
end
