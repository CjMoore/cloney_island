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
    user = current_user
    data = params
    if params[:contributor_email].empty?
      create_without_contributor(user, data)
    else
      is_valid_contributor(user, data)
    end
  end

  def create_without_contributor(user, data)
    @user = user
    @project = Project.new(project_params)
    days = params[:time][:month].to_i
    @project.time = (Time.now.to_date + days)
    if @project.save
      @role = Role.find_or_create_by(name: "project_owner")
      @user.roles << @role
      @user.owned_projects << @project
      flash[:notice] = "You just created a project without a contributor!"
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please try again."
      render :new
    end
  end

  def is_valid_contributor(user, data)
    contributor = User.find_by(email: params[:contributor_email])
     unless contributor.nil?
      create_with_valid_contributor(user, data, contributor)
    else
      flash[:warning] = "The email doesn't exit in our database."
      render :new
    end
  end

  def create_with_valid_contributor(user, data, contributor)
    @user = user
    @project = Project.new(project_params)
    days = params[:time][:month].to_i
    @project.time = (Time.now.to_date + days)
    @contributor = contributor
    if @project.save
      @role = Role.find_or_create_by(name: "project_owner")
      @user.roles << @role
      @user.owned_projects << @project
      @contributor.roles << @role
      @contributor.owned_projects << @project
      flash[:notice] = "A project was created with #{@contributor.first_name} as a joint owner."
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please add a valid email for the contributor."
      render :new
    end
  end

  def edit
    @project = Project.find_by_slug(params[:project_id])
  end

  def update
    @project = current_user.owned_projects.find(params[:id])
    if params[:contributor_email].empty?
      update_without_contributor
    else
      is_contributor_valid_update
    end
  end


  def update_without_contributor
    project = Project.find(params[:id])
    if project.update(project_params)
      flash[:notice] = "Your project has been updated."
      redirect_to project_path(project.slug)
    else
      flash[:warning] = "We were unable to update the project. Please try again."
      render :edit
    end
  end

  def is_contributor_valid_update
    contributor = User.find_by(email: params[:contributor_email])
    unless contributor.nil?
      update_project(contributor)
    else
     flash[:warning] = "The email doesn't exit in our database. Please remove the email or enter a valid email address."
     render :edit
   end
  end

  def update_project(contributor)
    binding.pry
    @role = Role.find_or_create_by(name: "project_owner")
    @project = Project.find(params[:id])
    if @project.update(project_params)
      contributor.roles << @role
      @project.owners << contributor
      flash[:notice] = "Your project has been updated."
      redirect_to project_path(@project.slug)
    else
      flash[:warning] = "Your project was not updated, please enter a valid collaborator."
      render :edit
    end
  end

  def update_status
    @user = current_user
    @project = current_user.owned_projects.find(params[:project_id])
    unless params.include?("status")
      project_update
    else
      check_status
    end
  end

  private

  def project_update
    if @project.update(project_params)
      redirect_to project_path(@project.slug)
      flash[:notice] = "You have successfully updated your project"
    else
      render :edit
      flash[:danger] = "Invalid input"
    end
  end

  def check_status
    if params["status"] == "disable"
      @project.disabled!
      redirect_to username_path(@user.slug)
    else
      @project.active!
      redirect_to username_path(@user.slug)
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :image_url, :total, :slug)
  end
end
