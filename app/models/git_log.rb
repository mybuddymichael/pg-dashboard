class GitLog < ActiveRecord::Base
  attr_accessible :author, :branch, :commit_time, :message, :sha
end
