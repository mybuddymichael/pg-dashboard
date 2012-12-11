class User
  def self.authenticate(username, password)
    PrimeApi.authenticate(username, password)
  end
end
