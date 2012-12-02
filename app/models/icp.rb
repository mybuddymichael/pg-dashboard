class Icp < ActiveRecord::Base
  if Rails.env == "production" || Rails.env == "development"
    establish_connection "pdms_accounts"
    self.table_name = "icp_master"
  end
end
