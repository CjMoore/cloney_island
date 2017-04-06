class UserFundedProjectsController < ApplicationController

  def new
    @funds = UserFundedProject.new
    @project = Project.find(params[:project_id])
  end

  def create
    @user = current_user
    @project = Project.find(params[:project_id])
    @fund = @user.user_funded_projects.new(project_params)
    if @fund.save
      @role = Role.find_or_create_by(name: "project_funder")
      @user.roles << @role
      flash.now[:notice] = "You just funded #{@project.name} for #{@fund.amount}!"
      redirect_to project_path(@project.slug)
    else
      flash[:error] = @fund.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def project_params
    params.require(:user_funded_project).permit(:amount, :credit_card_number).merge(project_id: params["project_id"])
  end
end
