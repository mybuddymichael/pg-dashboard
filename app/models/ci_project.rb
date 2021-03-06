class CiProject

  BASE_URL   = EnvVar::CI_HOSTNAME
  API_SUFFIX = "/api/json"
  OPTIONS_HASH = { basic_auth: { username: EnvVar::CI_USERNAME,
                                 password: EnvVar::CI_PASSWORD}}

  # Public: Return a list of all CI projects, instantiated as CiProject
  # objects.
  #
  # Returns an Array of CiProjects.
  def self.all
    list.collect do |project|
      find_by_name(project['name'])
    end
  end

  # Public: Find a single CiProject by name.
  #
  # Returns a CiProject.
  def self.find_by_name(name)
    project_info = list.find { |project| project["name"] == name.to_s}
    return nil if project_info.nil?
    project_hash = fetch_project_hash_by_name(project_info["name"])
    new(project_hash["name"],
        project_hash["url"],
        project_hash["lastBuild"]["number"],
        project_hash["lastBuild"]["url"])
  end

  # Public: Returns a String of the CiProject name.
  attr_reader :name

  # Public: Returns a String of the CiProject URL.
  attr_reader :url

  def initialize(name, url, last_build_number, last_build_url)
    @name = name
    @url = url
    @last_build_number = last_build_number
    @last_build_url = last_build_url
    @last_build = nil
  end

  # Public: Get the most recent build for the project as a CiBuild. The
  # build is stored for subsequent calls.
  #
  # Returns a CiBuild.
  def last_build
    @last_build ||=
      CiBuild.find_by_project_name_and_build_number(@name, @last_build_number)
  end

  private

  # Internal: Get a Hash of the project's properties, defined by the
  # CI app's API.
  #
  # Returns a Hash.
  def self.fetch_project_hash_by_name(name)
    Rails.logger.info(BASE_URL + "job/" + name + API_SUFFIX)
    response = HTTParty.get(BASE_URL + "job/" + name + API_SUFFIX, OPTIONS_HASH)
    ActiveSupport::JSON.decode(response.body)
  end
  private_class_method :fetch_project_hash_by_name

  # Internal: Get a list of all project names and URLs.
  #
  # Returns an Array of Hashes, each Hash having "name" and "url" keys.
  def self.list
    response = HTTParty.get(BASE_URL + API_SUFFIX, OPTIONS_HASH)
    ActiveSupport::JSON.decode(response.body)["jobs"]
  end
  private_class_method :list

end
