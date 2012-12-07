# == Schema Information
#
# Table name: user
#
#  userID         :integer          not null, primary key
#  companyID      :integer          default(1), not null
#  username       :string(45)       not null
#  password       :string(40)       not null
#  firstName      :string(45)       not null
#  lastName       :string(45)       not null
#  email          :string(45)       not null
#  phone          :string(45)       not null
#  title          :string(255)
#  role           :string(13)       not null
#  enabled        :boolean          default(FALSE), not null
#  verified       :boolean          default(FALSE), not null
#  emailVerified  :boolean          default(FALSE), not null
#  licenseVersion :integer          default(0), not null
#  licenseDate    :date
#  expirationDate :date
#

class User < ActiveRecord::Base
  if Rails.env == "production" || Rails.env == "development"
    establish_connection "pdms_accounts"
    self.table_name = "user"
  end


  def authenticate_signin (password)
    @user = User.find_by_password(
      Digest::SHA1.hexdigest(password + self.username))
    if @user && (@user.companyID == 1)
      return true
    else
      return false
    end
  end
end
