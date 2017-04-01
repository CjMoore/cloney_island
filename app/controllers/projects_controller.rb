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
end
