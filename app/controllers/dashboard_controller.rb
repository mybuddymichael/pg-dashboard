class DashboardController < ApplicationController

  def index
    @title = "ICP"
    icp_connect_interval = (120)  # seconds
    now = Time.now.utc - (60*60*8)
    @all_icps = Icp.find(:all).collect do |icp|
      status = "blue"
      if icp.last_connect_time < (now - icp_connect_interval)
        @status = "orange"
      elsif icp.last_sync_time < (now - (60*icp.sync_interval))
        @status = "orange"
      elsif icp.last_parse_time < (now - (2*60*icp.sync_interval))
        @status = "orange"
      end

      {
        "name" => icp.icp_name,
        "status" => @status,
      }
    end
    logger.info(@all_icps[0])
    logger.info("------------------------------------------------")
  end
end
