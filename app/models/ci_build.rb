class CiBuild

  BASE_URL   = EnvVar::CI_HOSTNAME
  API_SUFFIX = CiProject::API_SUFFIX
  OPTIONS_HASH = CiProject::OPTIONS_HASH

  # Public: Get a CiBuild object from a CiProject and build id.
  #
  # Returns a CiBuild.
  def self.find_by_project_name_and_build_number(project_name, build_number)
    build_url = BASE_URL + project_name + "/#{build_number}/"
    url = build_url + API_SUFFIX

    response = HTTParty.get(url, OPTIONS_HASH)
    build_hash = ActiveSupport::JSON.decode(response.body)

    new(build_hash["number"], build_hash["result"], build_url)
  end

  # Public: Returns a Fixnum of the build's number.
  attr_reader :number

  # Public: Returns a String of the build's result.
  attr_reader :result

  # Public: Returns a String of the build's URL.
  attr_reader :url

  def initialize(number, result, url)
    @number = number
    @result = result
    @url = url
  end

end
