module EnvVar
  DATABASE_USERNAME = ENV["dashboard_database_username"]
  DATABASE_PASSWORD = ENV["dashboard_database_password"]
  DATABASE_HOSTNAME = ENV["dashboard_database_hostname"]

  CI_USERNAME = ENV["dashboard_ci_username"]
  CI_PASSWORD = ENV["dashboard_ci_password"]

  self.constants.each do |constant|
    if EnvVar.const_get(constant).nil?
      raise TypeError, "EnvVar::#{constant} is nil! Define the relevant environment variable first."
    end
  end
end

