class RedmineIssue < ActiveResource::Base
  self.site = "http://redmine.progauge.us"
  self.user = ENV["redmine_username"]
  self.password  = ENV["redmine_api_token"]
  self.collection_name = "issues"
  self.format = :xml
end
