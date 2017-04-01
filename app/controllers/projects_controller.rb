class ProjectsController < ApplicationController
  def show
    @current_project ||= Project.find_by_slug(params[:id])
    @comment = Comment.new
  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @user = current_user
    @project = Project.new(project_params)
    if @project.save
      role = Role.find_or_create_by(name: "project_owner")
      @user.roles << role
      @project.owners << @user
      # @collaborator = User.find_or_create_by!(email: params[:contributor_email])
      # @project.owners << @collaborator
      flash[:notice] = "Your project has been created!"
      redirect_to username_path(@user.username)
    else
      flash[:warning] = "Please try again."
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :image_url, :total, :slug)
  end
end
