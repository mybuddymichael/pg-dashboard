class DashboardController < ApplicationController

  def index
    @title = "ICP"
    # @g = GitDetails.new('~/workspace/scada').remotes
  end
end
