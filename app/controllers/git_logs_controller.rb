class GitLogsController < ApplicationController

  def new
    if !GitLog.find_by_sha_and_branch(params["commit"],params["branch"])
      @git_commit = GitLog.new(
        :sha => params["commit"],
        :message => params["message"],
        :author => params["author"],
        :email => params["email"],
        :commit_time => DateTime.parse(params["date"]),
        :branch => params["branch"]
      )
      @git_commit.save
    end

    render :nothing => true
  end
end
