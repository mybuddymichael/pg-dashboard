class CiProject

  BASE_URL   = "http://jenkins.progauge.us/"
  API_SUFFIX = "/api/json"
  OPTIONS_HASH = { basic_auth: { username: ENV["jenkins_username"],
                                 password: ENV["jenkins_api_token"]}}

  # Public: Return a list of all CI projects, instantiated as CiProject
  # objects.
  #
  # Returns an Array of CiProjects.
  def self.all
    options = { basic_auth: { username: ENV["jenkins_username"],
                              password: ENV["jenkins_api_token"]}}
    response = HTTParty.get("http://jenkins.progauge.us/api/json", options)
    response_hash = ActiveSupport::JSON.decode(response.body)

    all_projects = response_hash["jobs"].collect do |job|
      new(job["name"], job["url"])
    end

    all_projects
  end

  # Public: Find a single CiProject by name.
  #
  # Returns a CiProject.
  def self.find_by_name(name)
    all_projects = self.all
    all_projects.find { |project| project.name == name.to_s}
  end

  # Returns the CiProject name.
  attr_reader :name

  # Returns the CiProject URL.
  attr_reader :url

  def initialize(name, url, last_build_number, last_build_url)
    @name = name
    @url = url
    @last_build_number = last_build_number
    @last_build_url = last_build_url
  end

  private

  # Internal: Get a list of all project names and URLs.
  #
  # Returns an Array of Hashes, each Hash having "name" and "url" keys.
  def self.list
    response = HTTParty.get(BASE_URL + API_SUFFIX, OPTIONS_HASH)
    ActiveSupport::JSON.decode(response.body)["jobs"]
  end

end
