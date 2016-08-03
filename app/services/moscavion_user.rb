class MoscavionUser
  def initialize(request, user_details = {}, action = :login)
    @errors = []
    @request = request
    send(action, user_details)
  end

  def login(user_details)
    user = get_user email: user_details[:email]
    validate_user user, user_details if user_exist? user
    if @errors.empty?
      @request.flash[:notice] = "Login Successful"
      @request.session[:user_id] = user.id
    else
      @request.flash[:errors] = @errors
    end
  end

  def signup(user_details)
    user = User.create user_details
    unless user.errors.empty?
      @request.flash[:errors] = user.errors.full_messages
      return
    end
    @request.flash[:notice] = "Signup Successful"
    @request.session[:user_id] = user.id
  end

  private

  def get_user(criteria = {})
    User.find_by(criteria)
  end

  def validate_user(user, details)
    user_exist? user
    if @errors.empty?
      auth = user.authenticate(details[:password])
      unless auth
        @errors << "User email or password incorrect"
        return
      end
    end
  end

  def user_exist?(user)
    if user.nil?
      @errors << "User not registered"
      return false
    end
    true
  end
end
