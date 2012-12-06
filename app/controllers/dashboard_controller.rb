class DashboardController < ApplicationController
  include ActionView::Helpers::DateHelper

  ICP_CONNECTION_THRESHOLD_IN_SECONDS = 300

  def index
    @title = "ICP"

    @all_icps = get_all_icps
    @ci_projects = get_all_ci_projects

    respond_to do |format|
      format.html
      format.json { render :json => { all_icps: @all_icps,
                                      all_ci_projects: @ci_projects}}
    end
  end

  private

  def get_all_icps
    now = Time.now
    @icps = Icp.all.collect do |icp|
      status = :good
      messages = []

      last_connect = convert_timezone_without_changing_time(icp.last_connect_time,
                                                            icp.timezone)
      last_sync = convert_timezone_without_changing_time(icp.last_sync_time,
                                                         icp.timezone)
      last_parse = convert_timezone_without_changing_time(icp.last_parse_time,
                                                          icp.timezone)

      if last_connect < (now - ICP_CONNECTION_THRESHOLD_IN_SECONDS)
        status = :bad
        messages.push("Last connection was #{time_ago_in_words(last_connect)} ago")
      end

      if last_sync < (now - (60 * icp.sync_interval))
        status = :bad
        messages.push("Last sync was #{time_ago_in_words(last_sync)} ago")
      end

      if last_parse < (now - (2 * 60 * icp.sync_interval))
        status = :bad
        messages.push("Last parse was #{time_ago_in_words(last_parse)} ago")
      end

      if !icp.icp_metadata.enabled?
        status = :ignored
      end

      { name: icp.icp_name,
        status: status,
        messages: messages }
    end

    # @icps.sort! { |a,b| a[:status] <=> b[:status] }
    @icps.sort_by { |icp| [icp[:status], icp[:name]]}
  end

  def get_all_ci_projects
    CiProject.all.collect do |project|
      result = (project.last_build.result == "SUCCESS") ? :good : :bad

      { name: project.name,
        url: project.url,
        last_build_result: result }
    end
  end

end
