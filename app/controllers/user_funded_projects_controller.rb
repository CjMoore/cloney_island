class UserFundedProjectsController < ApplicationController

  def new
    @funds = UserFundedProject.new
  end

end
