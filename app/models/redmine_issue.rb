class RedmineIssue < ActiveResource::Base
  self.site = EnvVar::ISSUE_TRACKER_HOSTNAME
  self.user = EnvVar::ISSUE_TRACKER_USERNAME
  self.password = EnvVar::ISSUE_TRACKER_PASSWORD
  self.collection_name = "issues"
  self.format = :xml
end
