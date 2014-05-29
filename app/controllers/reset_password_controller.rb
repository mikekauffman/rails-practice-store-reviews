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
    #p "EDIT USER: #{@user}"
      @reset_password = User.new
    else
      redirect_to login_path, alert: "That link has expired, please click 'Forgot Passsword?' link."
    end
  end

  def update
    @user = User.find_by(reset_token: params[:token])
    if @user.update_attributes(allowed_parameters)
      @user.update(reset_token: "")
      #p "IS TOKEN HERE?: #{@user.reset_token}"
      redirect_to :login
    else
      render :edit
    end
  end

  private

  def allowed_parameters
    params.require(:user).permit(:password, :password_confirmation)
  end

end