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

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  helper_method :is_admin?, :is_logged_in?, :current_cart
end

