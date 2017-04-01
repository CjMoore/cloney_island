class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @user.roles << Role.find_or_create_by(name: "registered_user")
      flash[:notice] = "Logged in as #{@user.first_name}"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @registered_user ||= User.find_by_slug(params[:username])
  end

  private

  def user_params
    params.required(:user)
                    .permit(:username,
                            :first_name,
                            :last_name,
                            :email,
                            :phone,
                            :password,
                            :password_confirmation,
                            :slug
                            )
  end
end
