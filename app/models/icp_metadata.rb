class IcpMetadata < ActiveRecord::Base
  belongs_to :icp
  attr_accessible :icp_id,
                  :enabled,
                  :check_connection,
                  :check_parsing,
                  :check_syncing
end
