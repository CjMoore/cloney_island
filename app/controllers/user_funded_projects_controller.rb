class UserFundedProjectsController < ApplicationController

  def new
    @funds = UserFundedProject.new
    @project = Project.find(params[:project_id])
  end

end
