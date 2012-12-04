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

require 'test_helper'

class IcpMetadataTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
