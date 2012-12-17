class GitLogsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:update_git]

  def update_git

    params.first[1].each do |p|
      if !GitLog.find_by_sha_and_branch(p["commit"],p["branch"])
        GitLog.create(
          :sha => p["commit"],
          :message => p["message"],
          :author => p["author"],
          :email => p["email"],
          :commit_time => DateTime.parse(p["date"]),
          :branch => p["branch"]
        )
      end
    end

    render :nothing => true
  end
end
