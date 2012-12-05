class DashboardController < ApplicationController

  ICP_CONNECTION_THRESHOLD_IN_SECONDS = 180

  def index
    @title = "ICP"
    now = Time.now.utc

    @all_icps = Icp.find(:all).collect do |icp|
      status = :good
      messages = []
      last_connect = convert_time(icp.last_connect_time, icp.timezone)

      if icp.last_connect_time < (now - ICP_CONNECTION_THRESHOLD_IN_SECONDS)
        status = :bad
        messages.push("Last connection was at #{icp.last_connect_time}")
      end

      if icp.last_sync_time < (now - (60 * icp.sync_interval))
        status = :bad
        messages.push("Last sync was at #{icp.last_sync_time}")
      end

      if icp.last_parse_time < (now - (2 * 60 * icp.sync_interval))
        status = :bad
        messages.push("Last parse was at #{icp.last_parse_time}")
      end

      { name: icp.icp_name,
        status: status,
        messages: messages }
    end

    @ci_projects = CiProject.all.collect do |project|
      result = (project.last_build.result == "SUCCESS") ? :good : :bad

      { name: project.name,
        url: project.url,
        last_build_result: result }
    end

    logger.info(@all_icps[0])
    logger.info("------------------------------------------------")
  end


  private

  def convert_time (time, timezone)
    logger.info("--------------------------------------------")
    logger.info(timezone)
    tz = TZInfo::Timezone.get(timezone).current_period.utc_total_offset
    tz = tz / 3600
    converted_time = time.to_datetime.change(offset: "#{tz}")

    converted_time.utc
  end
end
