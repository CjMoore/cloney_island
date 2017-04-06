class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 70)
    @user_roles = UserRole.all
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
    @registered_user = current_user
  end

  def edit
    @user = User.find_by_slug(params[:slug])
  end

  def update
    @user = current_user
    if params[:commit] == "Update Password"
      change_password
    elsif params[:update] == "admin"
      update_admin
    else
      update_user
    end
  end

  def update_password
    unless @user.token.nil?
      TwilioService.new(@user).send_message
    else
      flash[:danger] = "I'm sorry, I can't let you do that"
      redirect_to "/#{@user.slug}"
    end
  end

  def update_user_status
      if params[:update_user_status] == "deactivated"
        user = User.find_by_slug(params[:username])
        user.roles << Role.find_or_create_by(name: "deactivated_user")
        user.roles.delete(Role.find_by(name: "registered_user"))
        redirect_to users_path
      else
        user = User.find_by_slug(params[:username])
        user.roles << Role.find_or_create_by(name: "registered_user")
        user.roles.delete(Role.find_by(name: "deactivated_user"))
        redirect_to users_path
    end
  end

  private


  def update_admin
    if params[:revoke] == "admin"
      user_to_update = User.find_by_slug(params[:username])
      user_to_update.roles.delete(Role.find_by(name: "admin_user"))
      redirect_to users_path
    else
      user_to_update = User.find_by_slug(params[:username])
      user_to_update.roles << Role.find_or_create_by(name: "admin_user")
      redirect_to users_path
    end
  end

  def update_user
    @user.update_attributes(user_params)
    if @user.save
      flash[:notice] = "Account info updated"
      redirect_to "/#{@user.slug}"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def change_password
    if @user && @user.authenticate(params[:user][:password])
      check_token
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to "/#{@user.slug}/update_password"
    end
  end

  def check_token
    if params[:token] == @user.token
      @user.update_attribute(:password, params[:new_password])
      redirect_to "/#{@user.slug}"
    else
      flash[:danger] = "Invalid Token password unchanged"
      redirect_to "/#{@user.slug}/update_password"
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
