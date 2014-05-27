class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_admin?
    if session[:id].present? && User.find(session[:id]).admin
      true
    end
  end

  def is_logged_in?
    if session[:id].present? && User.find(session[:id])
      true
    end
  end

  helper_method :is_admin?, :is_logged_in?
end
