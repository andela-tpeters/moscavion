module ApplicationHelper
  def notice
    render partial: "partials/notice_message"
  end

  def error_msg
    render partial: "partials/error_message_display"
  end

  def login_msg
    render partial: "partials/login_msg"
  end

  def disable_profile_link
    if session[:user_id].nil?
      "ui button basic disabled"
    else
      "ui button basic"
    end
  end

  def display_errors(msgs)
    if msgs.is_a? Array
      msgs.map.with_index(1) { |x, index| "<li>#{index}. #{x}</li>" }.join
    else
      msgs
    end
  end
end
