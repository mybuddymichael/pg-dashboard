# == Schema Information
#
# Table name: icp_metadata
#
#  icp_id           :integer          not null
#  enabled          :boolean          default(TRUE)
#  check_connection :boolean          default(TRUE)
#  check_parsing    :boolean          default(TRUE)
#  check_syncing    :boolean          default(TRUE)
#

class IcpMetadata < ActiveRecord::Base
  belongs_to :icp
  attr_accessible :enabled,
                  :check_connection,
                  :check_parsing,
                  :check_syncing
end
