class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(user)
    else
      flash[:error] = "#{error_message(user.errors)}"
      redirect_to register_user_path
    end
  end

  def discover
    @user = User.find(params[:user_id])
  end

  def login_form

  end

  def login_user
    # require 'pry';binding.pry
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      cookies[:location] = params[:location]
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
