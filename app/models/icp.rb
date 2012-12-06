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

class Icp < ActiveRecord::Base
  if Rails.env == "production" || Rails.env == "development"
    establish_connection "pdms_accounts"
    self.table_name = "icp_master"
  end

  # Public: Get the IcpMetadata object belonging to an ICP.
  #
  # Returns nil or an IcpMetadata object.
  has_one :icp_metadata

  # Public: Get one of the class's time properties with the correct time
  # but also including the timezone.
  #
  # Returns a DateTime object.
  [:last_sync_time, :last_parse_time, :last_connect_time].each do |attribute|
    define_method(attribute) do
      convert_to_timezone_without_changing_time(read_attribute(attribute),
                                                read_attribute(:timezone))
    end
  end

  private

  # Internal: Convert an ActiveSupport::TimeWithZone object to the
  # provided timezone without modifying the time.
  #
  # Returns a DateTime object.
  def convert_to_timezone_without_changing_time(time, timezone)
    offset = ActiveSupport::TimeZone.new(timezone).utc_offset / 3600
    time.to_datetime.change(offset: "#{offset}")
  end
end
