class User
  extend PrimeApi

  def self.authenticate(username, password)
    response_hash = get_response(username, password)
    response_hash["messageType"] == "InvalidRequest" ? false : true
  end
end
