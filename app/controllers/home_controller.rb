class HomeController < ApplicationController
  def index
    @top_projects = Project.closest_funded
  end
end
