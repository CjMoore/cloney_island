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

  def edit
    @user = User.find_by_slug(params[:slug])
  end

  def update
    if params[:commit] == "Update Password"
      @user = current_user
      if @user && @user.authenticate(params[:user][:password])
        byebug
        TwilioService.new(@user).send_message
        if params[:token] == @user.token
          @user.update_attribute(:password, params[:new_password])
          redirect_to "/#{@user.slug}"
        else
          flash[:danger] = "invalid input"
          render :update_password
        end
      else
        flash[:danger] = "invalid input"
        render :update_password
      end
    else
      @user = current_user
      @user.update_attributes(user_params)
      if @user.save
        flash[:notice] = "Account info updated"
        redirect_to "/#{@user.slug}"
      else
        flash[:danger] = "invalid input"
        render :edit
      end
    end
  end

  def update_password
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
                            :avatar_url,
                            :slug
                            )
  end
end
