class ProjectsController < ApplicationController
  def show
    @current_project ||= Project.find_by_slug(params[:id])
    @comment = Comment.new
  end

  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 24)
  end

  def new
    @project = Project.new
  end

  def create
    @user = current_user
    @project = Project.new(project_params)
    @role = Role.find_or_create_by(name: "project_owner")
    if params[:contributor_email].empty?
      create_without_contributor
    else
      is_valid_contributor
    end
  end

  def edit
    @project = Project.find_by_slug(params[:project_id])
  end

  def update
    @user = current_user
    @project = @user.owned_projects.find(params[:id])
    @role = Role.find_or_create_by(name: "project_owner")
    if params[:contributor_email].empty?
      update_without_contributor
    else
      is_contributor_valid_update
    end
  end

  def update_status
    @user = current_user
    @project = current_user.owned_projects.find(params[:project_id])
    if params["status"] == "disable"
      @project.disabled!
      redirect_to username_path(@user.slug)
    else
      @project.active!
      redirect_to username_path(@user.slug)
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :image_url, :total, :slug)
  end

  def update_without_contributor
    if @project.update(project_params)
      flash[:notice] = "Your project has been updated."
      redirect_to project_path(@project.slug)
    else
      flash[:warning] = "Please enter valid information to update the project."
      render :edit
    end
  end

  def is_contributor_valid_update
    @contributor = User.find_by(email: params[:contributor_email])
    unless @contributor.nil?
      update_project
    else
      flash[:warning] = "The email doesn't exit in our database. Please remove the email or enter a valid email address."
      render :edit
    end
  end

  def update_project
    if @project.update(project_params)
      @contributor.roles << @role
      @project.owners << @contributor
      flash[:notice] = "Your project has been updated."
      redirect_to project_path(@project.slug)
    else
      flash[:warning] = "Your project was not updated, please enter valid project information."
      render :edit
    end
  end

  def create_without_contributor
    days = params[:time][:month].to_i
    @project.time = (Time.now.to_date + days)
    if @project.save
      @user.roles << @role
      @user.owned_projects << @project
      flash[:notice] = "You just created a project without a contributor!"
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Invalid input"
      render :new
    end
  end

  def is_valid_contributor
    @contributor = User.find_by(email: params[:contributor_email])
     unless @contributor.nil?
      create_with_valid_contributor
    else
      flash[:warning] = "The email doesn't exit in our database."
      render :new
    end
  end

  def create_with_valid_contributor
    days = params[:time][:month].to_i
    @project.time = (Time.now.to_date + days)
    if @project.save
      @user.roles << @role
      @user.owned_projects << @project
      @contributor.roles << @role
      @contributor.owned_projects << @project
      flash[:notice] = "A project was created with #{@contributor.first_name} as a joint owner."
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please add valid information for your project."
      render :new
    end
  end
end
