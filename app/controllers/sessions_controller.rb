class SessionsController < ApplicationController

  def new
    @title = "Sign In"
  end

  def create
    @user = User.find_by_username(params[:session][:username].downcase)
    if @user && @user.authenticate_signin(params[:session][:password])
      redirect_to root_path
    else
      flash[:error] = "Invalid email/password combination!"
      render 'new'
    end
  end

  def destroy
  end
end
