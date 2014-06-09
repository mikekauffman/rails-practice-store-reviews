class RegisterController < ApplicationController

  def create
    if user.present? && decrypted_password(user.password_digest) == params[:session][:password]
      session[:id] = user.id
      flash[:notice] = "Welcome #{user.email}"
      redirect_to root_path
    else
      redirect_to login_path, notice: 'invalid username/password'
    end
  end

  private

  def decrypted_password(password)
    BCrypt::Password.new(password)
  end
end