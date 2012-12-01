class CiProject < ActiveResource::Base
  self.site = "http://jenkins.progauge.us/"
  self.user = ENV["jenkins_username"]
  self.password = ENV["jenkins_api_token"]
  self.collection_name = "job"

  def self.element_path(name, prefix_options = {}, query_options = nil)
    check_prefix_options(prefix_options)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}#{collection_name}/#{URI.parser.escape name.to_s}/api/json#{query_string(query_options)}"
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    check_prefix_options(prefix_options)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}api/json#{query_string(query_options)}"
  end

  def self.all
    format.decode(connection.get(collection_path, {}).body)["jobs"].collect do |job|
      find job["name"]
    end
  end
end
