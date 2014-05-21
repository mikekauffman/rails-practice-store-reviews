class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email])

    if user.present? && decrypted_password(user.password_digest) == params[:session][:password]
      session[:id] = user.id
      redirect_to root_path
    else
      redirect_to login_path, alert: 'invalid email/password'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
  private

  def decrypted_password(password)
    BCrypt::Password.new(password)
  end
end