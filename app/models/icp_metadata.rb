class IcpMetadata < ActiveRecord::Base
  belongs_to :icp
  attr_accessible :enabled,
                  :check_connection,
                  :check_parsing,
                  :check_syncing
end
