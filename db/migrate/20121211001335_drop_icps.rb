class DropIcps < ActiveRecord::Migration
  def up
    drop_table :icps
  end

  def down
    create_table :icps do |t|
      t.integer   "company_id",                                                                :null => false
      t.string    "field_name",              :limit => 40,                                     :null => false
      t.string    "lease_name",              :limit => 120,                                    :null => false
      t.string    "area_name",               :limit => 40,                                     :null => false
      t.string    "icp_name",                :limit => 120,                                    :null => false
      t.string    "schema_name",                                                               :null => false
      t.string    "prime_schema_name",                                                         :null => false
      t.integer   "sync_interval",                          :default => 1440,                  :null => false
      t.integer   "sync_appointment_window",                :default => 5,                     :null => false
      t.timestamp "last_sync_time",                         :default => '2009-01-01 00:00:00', :null => false
      t.timestamp "last_parse_time",                        :default => '2009-01-01 00:00:00', :null => false
      t.timestamp "last_connect_time",                                                         :null => false
      t.string    "ip_address",              :limit => 39,                                     :null => false
      t.integer   "tunnel_port",                                                               :null => false
      t.string    "mac_address",             :limit => 45,                                     :null => false
      t.string    "username",                :limit => 45,                                     :null => false
      t.string    "password",                :limit => 45,                                     :null => false
      t.string    "bios_password",           :limit => 45,                                     :null => false
      t.boolean   "deployed",                               :default => false,                 :null => false
      t.string    "timezone",                               :default => "UTC",                 :null => false
    end
  end
end
