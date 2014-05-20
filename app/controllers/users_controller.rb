class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(allowed_parameters)

    if user.save
      session[:id] = user.id
      UserMailer.welcome_email(user).deliver
      redirect_to root_path
    else
      @user = user
      redirect_to new_user_path, alert: "invalid email/password"
    end

  end

  private

  def allowed_parameters
    params.require(:user).permit(:email, :password)
  end
  end