module SessionsHelper
  #
  # Method sign_in, It's used to
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token]= remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user= user
  end

  # Method used to check the user's existence or not..
  def signed_in?
    !current_user.nil?
  end

  # Method used to determine the current user who was logged onto the system
  def current_user=(user)
    @current_user= user
  end

  #
  # Method used to determine the sign out or not
  #
  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Method used to define he current users
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # Method returns the existence of current user or not...
  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
