class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 70)
  end

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

  def edit
    @user = User.find_by_slug(params[:slug])
  end

  def update
    @user = current_user
    if params[:commit] == "Update Password"
      change_password
    else
      update_user
    end
  end

  def update_password
    unless @user.phone.chars.include?("-")
      TwilioService.new(@user).send_message
    else
      flash[:notice] = "Invalid phone number"
      redirect_to "/#{@user.slug}"
    end
  end

  private

  def update_user
    @user.update_attributes(user_params)
    if @user.save
      flash[:notice] = "Account info updated"
      redirect_to "/#{@user.slug}"
    else
      flash[:danger] = "Invalid Input"
      render :edit
    end
  end

  def change_password
    if @user && @user.authenticate(params[:user][:password])
      check_token
    else
      flash[:danger] = "Invalid Input"
      render :update_password
    end
  end

  def check_token
    if params[:token] == @user.token
      @user.update_attribute(:password, params[:new_password])
      redirect_to "/#{@user.slug}"
    else
      flash[:danger] = "Invalid Token"
      render :update_password
    end
  end

  def user_params
    params.required(:user)
                    .permit(:username,
                            :first_name,
                            :last_name,
                            :email,
                            :phone,
                            :password,
                            :password_confirmation,
                            :avatar_url,
                            :slug
                            )
  end
end
