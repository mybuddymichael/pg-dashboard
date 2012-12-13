# == Schema Information
#
# Table name: git_logs
#
#  id          :integer          not null, primary key
#  sha         :string(255)
#  message     :string(255)
#  author      :string(255)
#  email       :string(255)
#  commit_time :datetime
#  branch      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GitLog < ActiveRecord::Base
  attr_accessible :author, :branch, :email, :commit_time, :message, :sha
end
