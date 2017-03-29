class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:danger] = "Username or Password are Incorrect"
      render :new
    end
  end

  def destroy
      session[:user_id] = nil
      flash[:notice] = "You have successfully logged out"
      redirect_to root_path
  end
end
