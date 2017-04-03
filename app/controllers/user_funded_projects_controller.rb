class UserFundedProjectsController < ApplicationController

  def new
    @funds = UserFundedProject.new
    @project = Project.find(params[:project_id])
  end

  def create
    @user = current_user
    @project = Project.find(params[:project_id])
    fund = @user.user_funded_projects.create(project_params)
    @role = Role.find_or_create_by(name: "project_funder")
    @user.roles << @role
    @project.funders << @user
    flash.now[:notice] = "You just funded #{@project.name} for #{fund.amount}!"
    redirect_to project_path(@project.slug)
  end

  private

  def project_params
    params.require(:user_funded_project).permit(:amount, :credit_card_number).merge(project_id: params["project_id"])
  end
end
