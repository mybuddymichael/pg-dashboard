class DashboardController < ApplicationController
  before_filter :signed_in_user

  include ActionView::Helpers::DateHelper

  ICP_CONNECTION_THRESHOLD_IN_SECONDS = 1800

  def index
    @title = "ICP"

    @all_icps = get_all_icps
    @ci_projects = get_all_ci_projects

    respond_to do |format|
      format.html { render layout: false  if request.xhr? }
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

      last_connect = icp.last_connect_time
      last_sync = icp.last_sync_time
      last_parse = icp.last_parse_time

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

      { name: icp.name,
        status: status,
        messages: messages }
    end

    @icps.sort_by { |icp| [icp[:status], icp[:name]]}
  end

  def get_all_ci_projects
    @ci_projects = CiProject.all.collect do |project|
      if project.last_build.result == "SUCCESS"
        result = :good
      elsif project.last_build.result == nil
        result = :ignored
      else
        result = :bad
      end

      { name: project.name,
        last_build_result: result,
        last_build_url: project.last_build.url }
    end
    @ci_projects.sort_by { |project| [project[:last_build_result], project[:name]]}
  end

end
