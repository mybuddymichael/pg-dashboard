class GitLogsController < ApplicationController
  
  def new
    @git_commit = GitLog.new(
      :sha => params["commit"],
      :message => params["message"],
      :author => params["author"],
      :email => params["email"],
      :commit_time => DateTime.parse(params["date"]),
      :branch => params["branch"]
    )

    @git_commit.save
    render :nothing => true
  end
end
