class HomeController < ApplicationController
  def index
    @top_projects = Project.all.limit(3)
  end
end
