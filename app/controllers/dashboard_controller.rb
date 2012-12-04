class DashboardController < ApplicationController

  def index
    @title = "ICP"
    @icp_connect_interval = (120)  # seconds
    @icps = Icp.all
    @now = Time.now.utc - (60*60*8) - (@icp_connect_interval)
  end
end
