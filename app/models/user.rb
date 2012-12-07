class User < ActiveRecord::Base
  if Rails.env == "production" || Rails.env == "development"
    establish_connection "pdms_accounts"
    self.table_name = "user"
  end


  def authenticate_signin (password)
    @user = User.find_by_password(
      Digest::SHA1.hexdigest(password + self.username))
    if @user
      return true
    else
      return false
    end
  end
end
