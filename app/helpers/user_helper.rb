module UserHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_off(user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
