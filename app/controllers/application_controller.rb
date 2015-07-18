class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_day

  private
  def current_user
    @current_user ||= Users.find(session[:user_id]) if session[:user_id]
  end

  private
  def current_day
    @current_day ||= Day.find(session[:day_id]) if session[:day_id]
  end

end
