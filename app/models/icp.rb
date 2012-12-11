class Icp
  extend PrimeApi



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
