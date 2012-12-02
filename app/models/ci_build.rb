class CiBuild

  BASE_URL   = "http://jenkins.progauge.us/job/"
  API_SUFFIX = CiProject::API_SUFFIX
  OPTIONS_HASH = CiProject::OPTIONS_HASH

  # Public: Get a CiBuild object from a CiProject and build id.
  #
  # Returns a CiBuild.
  def self.find_by_project_name_and_build_id(project_name, build_id)
    url = BASE_URL + project_name + "/#{build_id}/" + API_SUFFIX
    response = HTTParty.get(url, OPTIONS_HASH)
    build_hash = ActiveSupport::JSON.decode(response.body)
    new(build_hash["number"],
        build_hash["result"],
        build_hash["actions"][5]["failCount"],
        build_hash["actions"][5]["totalCount"])
  end

  attr_reader :id

  def initialize(id, result, failed_tests, total_tests)
    @id = id
    @result = result
    @failed_tests = failed_tests
    @total_tests = total_tests
  end
end
