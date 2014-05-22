class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(allowed_parameters)
    @user = user
    if user.save
      session[:id] = user.id
      UserMailer.welcome_email(user).deliver
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def allowed_parameters
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
