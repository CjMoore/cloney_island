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
      flash[:notice] = "You just created a project without a contributor!"
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please try again."
      render :new
    end
  end

  def is_valid_contributor(user, data)
    contributor = User.find_by(email: params[:contributor_email])
     if !contributor.nil?
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
      @contributor.roles << @role
      flash[:notice] = "A project was created with #{@contributor.first_name} as a joint owner."
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please add a valid email for the contributor."
      render :new
    end
  end

  def edit
    @project = Project.find_by_slug(params[:id])
  end

  def update
    project = Project.find_by_slug(params[:project_id])
    if project.update(project_params)
      redirect_to project_path(project.slug)
    else
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :image_url, :total, :slug)
  end
end
