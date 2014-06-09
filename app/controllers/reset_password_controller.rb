class ResetPasswordController < ApplicationController

  def new
    @reset_password = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user != nil
      token = SecureRandom.uuid
      @user.update(reset_token: token)
      UserMailer.reset_password(@user).deliver
    end
    redirect_to root_path, notice: "A Reset email has been sent if email is valid."
  end

  def edit
    @user = User.find_by(reset_token: params[:reset_token])
    if @user != nil
      @reset_password = User.new
    else
      redirect_to login_path, alert: "That link has expired, please click 'Forgot Passsword?' link."
    end
  end

  def update
    @user = User.find_by(reset_token: params[:token])
    if @user.update_attributes(password: params[:user][:password].presence, password_confirmation: params[:user][:password_confirmation].presence)
      @user.update(reset_token: "")
      redirect_to :login, notice: "Please use your new password to login."
    else
      render :edit
    end
  end

  private

  def allowed_parameters
    params.require(:user).permit(:password, :password_confirmation)
  end

end