module SessionHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remove user from session
  def logout
    session.delete :user_id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?
    !current_user.nil?
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
end
