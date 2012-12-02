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
    list_of_projects = list

    all_ci_projects = list_of_projects.collect do |job|
      project_response = HTTParty.get(BASE_URL + "job/" + job["name"] + "/" + API_SUFFIX, OPTIONS_HASH)
      project_hash = ActiveSupport::JSON.decode(project_response.body)
      new(project_hash["name"], project_hash["url"], project_hash["lastBuild"]["number"], project_hash["lastBuild"]["url"])
    end

    all_ci_projects
  end

  # Public: Find a single CiProject by name.
  #
  # Returns a CiProject.
  def self.find_by_name(name)
    project_info = list.find { |project| project["name"] == name.to_s}
    project_hash = fetch_project_hash_by_name(project_info["name"])
    new(project_hash["name"], project_hash["url"], project_hash["lastBuild"]["number"], project_hash["lastBuild"]["url"])
  end

  # Returns the CiProject name.
  attr_reader :name

  # Returns the CiProject URL.
  attr_reader :url

  # Returns the ID number for the project's last build.
  attr_reader :last_build_number

  # Returns the URL for the project's last build.
  attr_reader :last_build_url

  def initialize(name, url, last_build_number, last_build_url)
    @name = name
    @url = url
    @last_build_number = last_build_number
    @last_build_url = last_build_url
  end

  private

  def self.fetch_project_hash_by_name(name)
    response = HTTParty.get(BASE_URL + "job/" + name + API_SUFFIX, OPTIONS_HASH)
    ActiveSupport::JSON.decode(response.body)
  end

  # Internal: Get a list of all project names and URLs.
  #
  # Returns an Array of Hashes, each Hash having "name" and "url" keys.
  def self.list
    response = HTTParty.get(BASE_URL + API_SUFFIX, OPTIONS_HASH)
    ActiveSupport::JSON.decode(response.body)["jobs"]
  end

end
