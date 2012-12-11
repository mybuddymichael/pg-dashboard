class Icp

  extend PrimeApi

  def self.all
    response_hash = get_response
    response_hash["icps"].collect do |icp|
      new(name: icp["name"],
          last_connect_time: icp["lastConnectedToPrime"],
          last_sync_time: icp["lastSynchronization"],
          last_parse_time: icp["lastParse"],
          sync_interval: icp["synchronizationInterval"])
    end
  end

  attr_reader :name

  attr_reader :last_connect_time

  attr_reader :last_sync_time

  attr_reader :last_parse_time

  attr_reader :sync_interval

  def initialize(options)
    @name = options[:name]
    @last_connect_time = DateTime.parse(options[:last_connect_time])
    @last_sync_time = DateTime.parse(options[:last_sync_time])
    @last_parse_time = DateTime.parse(options[:last_parse_time])
    @sync_interval = options[:sync_interval]
  end

end
