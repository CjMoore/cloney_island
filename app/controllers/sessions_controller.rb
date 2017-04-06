class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.deactivated_user?
      flash[:danger] = "You have been banned from Crowdfunder!"
      redirect_to root_path
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:danger] = "Username or Password are Incorrect"
      render :new
    end
  end

  def destroy
      session.clear
      flash[:notice] = "You have successfully logged out"
      redirect_to login_path
  end
end
