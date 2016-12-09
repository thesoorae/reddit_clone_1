class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def current_user

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login
    flash[:errors] = ["can't view this page"] unless current_user
  end

end
