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
    days = params[:time][:month].to_i
    @project.update_attribute(:time, (Time.now.to_date + days) )
    if @project.save
      @role = Role.find_or_create_by(name: "project_owner")
      @user.roles << @role
      @project.owners << @user
      @contributor = User.find_by(email: params[:contributor_email])
        if !@contributor.nil?
          @contributor.roles << @role
          @project.owners << @contributor
          flash.now[:notice] = "You just added a new project owner."
        else
          flash.now[:warning] = "This email doesn't exist in our database and we cannot add them as a project owner."
        end
      flash[:notice] = "Your project has been created!"
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please try again."
      render :new
    end
  end

  def edit
    @project = Project.find_by_slug(params[:project_id])
  end

  def update
    @project = current_user.owned_projects.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project.slug)
      flash[:notice] = "You have successfully updated your project"
    else
      render :edit
      flash[:danger] = "Invalid input"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :image_url, :total, :slug)
  end
end
