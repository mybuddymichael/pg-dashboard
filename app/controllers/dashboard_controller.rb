class DashboardController < ApplicationController

  def index
    @title = "ICP"
    @allJobs = CiJob.all
  end
end
