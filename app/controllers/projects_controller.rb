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
    @username = current_user.username
    @project = Project.new(project_params)
    if @project.save
      #create a record in user owned projects table
      flash[:notice] = "Your project has been created!"
      redirect_to username_path(@username)
    else
      flash[:warning] = "Please try again."
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :image_url, :total, :time, :slug)
  end
end
