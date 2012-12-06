# == Schema Information
#
# Table name: icp_master
#
#  id                      :integer          not null, primary key
#  company_id              :integer          not null
#  field_name              :string(40)       not null
#  lease_name              :string(120)      not null
#  area_name               :string(40)       not null
#  icp_name                :string(120)      not null
#  schema_name             :string(255)      not null
#  prime_schema_name       :string(255)      not null
#  sync_interval           :integer          default(1440), not null
#  sync_appointment_window :integer          default(5), not null
#  last_sync_time          :timestamp        default(2009-01-01 00:00:00 UTC), not null
#  last_parse_time         :timestamp        default(2009-01-01 00:00:00 UTC), not null
#  last_connect_time       :timestamp        not null
#  ip_address              :string(39)       not null
#  tunnel_port             :integer          not null
#  mac_address             :string(45)       not null
#  username                :string(45)       not null
#  password                :string(45)       not null
#  bios_password           :string(45)       not null
#  deployed                :boolean          default(FALSE), not null
#  timezone                :string(255)      default("UTC"), not null
#

require 'test_helper'

class IcpTest < ActiveSupport::TestCase
  test 'last_sync_time returns the correct time but in UTC -8' do
    assert_equal(DateTime.new(2012, 12, 05, 20, 40, 43, '-8'),
                 Icp.find(1).last_sync_time)
  end

  test 'last_parse_time returns the correct time but in UTC -8' do
    assert_equal(DateTime.new(2012, 12, 05, 20, 28, 19, '-8'),
                 Icp.find(1).last_parse_time)
  end

  test 'last_connect_time returns the correct time but in UTC -8' do
    assert_equal(DateTime.new(2012, 12, 05, 20, 41, 06, '-8'),
                 Icp.find(1).last_connect_time)
  end
end
