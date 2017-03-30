class ProjectsController < ApplicationController
  def show
    @current_project ||= Project.find_by_slug(params[:id])
  end

  def index
    @projects = Project.all
  end
end
