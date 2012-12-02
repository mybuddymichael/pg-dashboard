class DashboardController < ApplicationController

  def index
    @title = "ICP"
    @allJobs = CiProject.all
  end
end
