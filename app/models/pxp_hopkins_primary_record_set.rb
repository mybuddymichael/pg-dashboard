class PxpHopkinsPrimaryRecordSet < ActiveRecord::Base
  if Rails.env == "production"
    establish_connection "client_icp_pxp_hopkins"
    self.table_name = "sync_icp_record_set"
  end
end
