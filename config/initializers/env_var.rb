Rails.application.config.before_configuration do
  module EnvVar
    DATABASE_USERNAME = ENV["dashboard_database_username"]
    DATABASE_PASSWORD = ENV["dashboard_database_password"]
    DATABASE_HOSTNAME = ENV["dashboard_database_hostname"]
    DATABASE_PORT = ENV["dashboard_database_port"]

    CI_USERNAME = ENV["dashboard_ci_username"]
    CI_PASSWORD = ENV["dashboard_ci_password"]
    CI_HOSTNAME = ENV["dashboard_ci_hostname"]

    ISSUE_TRACKER_USERNAME = ENV["dashboard_issue_tracker_username"]
    ISSUE_TRACKER_PASSWORD = ENV["dashboard_issue_tracker_password"]
    ISSUE_TRACKER_HOSTNAME = ENV["dashboard_issue_tracker_hostname"]

    self.constants.each do |constant|
      if EnvVar.const_get(constant).nil?
        raise TypeError, "EnvVar::#{constant} is nil! Define the relevant environment variable first. (See `config/initializers/env_var.rb` for necessary env vars.)"
      end
    end
  end
end
