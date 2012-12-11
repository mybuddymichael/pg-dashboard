class SessionsController < ApplicationController

  def new
    @title = "Sign In"
  end

  def create
    user = params[:session][:username]
    password = params[:session][:password]

    if User.authenticate(user, password)
      sign_in(user)
      redirect_to root_path
    else
      flash[:error] = "Invalid email/password combination!"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
