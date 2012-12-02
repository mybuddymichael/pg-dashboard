class CiProject

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

  def initialize(name, url)
    @name = name
    @url = url
  end

end