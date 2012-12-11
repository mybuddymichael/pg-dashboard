module PrimeApi
  module_function

  eval(EnvVar::PRIME_API_HASH_FUNCTION)

  def authenticate(username, password)
    unless username and password
      raise ArgumentError, "username or password cannot be nil"
    end

    response_hash = self.get_response(username, password)
    response_hash["messageType"] == "InvalidRequest" ? false : true
  end

  def get_response(username, password)
    hash = hash_function(username, password)

    n1 = SecureRandom.random_number(100000) + 1
    n2 = SecureRandom.random_number(100000) + 1
    h1 = Digest::SHA1.hexdigest(n1.to_s + hash + n2.to_s + username)
    h2 = Digest::SHA1.hexdigest(n2.to_s + hash + n1.to_s)

    request_hash = {
      headers: {
        'Content-Type' => 'application/json'
      },
      body: ActiveSupport::JSON.encode({
        messageType: 'ICPMetaDataRequest',
        messageID: SecureRandom.uuid,
        'b81f3779-42c8-4aa2-9231-03e7f7284701' => {
          '75f365b8-2f7d-4574-99c1-8c144a648494' => n1.to_s,
          'a867fb6e-1e16-4725-a939-e1bbcf987966' => n2.to_s,
          '988871a4-d095-4879-96ea-f0603497068c' => h1,
          '8cd8e43a-3d8c-4d38-88ff-2f01bc5d1c18' => h2
        }
      })
    }

    response = HTTParty.post(EnvVar::PRIME_API_HOSTNAME, request_hash)
    ActiveSupport::JSON.decode(response.body)
  end
end
