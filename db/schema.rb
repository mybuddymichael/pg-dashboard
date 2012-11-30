# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121130040148) do

  create_table "icps", :force => true do |t|
    t.integer  "company_id",                                                                :null => false
    t.string   "field_name",              :limit => 40,                                     :null => false
    t.string   "lease_name",              :limit => 120,                                    :null => false
    t.string   "area_name",               :limit => 40,                                     :null => false
    t.string   "icp_name",                :limit => 120,                                    :null => false
    t.string   "schema_name",                                                               :null => false
    t.string   "prime_schema_name",                                                         :null => false
    t.integer  "sync_interval",                          :default => 1440,                  :null => false
    t.integer  "sync_appointment_window",                :default => 5,                     :null => false
    t.datetime "last_sync_time",                         :default => '2009-01-01 00:00:00', :null => false
    t.datetime "last_parse_time",                        :default => '2009-01-01 00:00:00', :null => false
    t.datetime "last_connect_time",                                                         :null => false
    t.string   "ip_address",              :limit => 39,                                     :null => false
    t.integer  "tunnel_port",                                                               :null => false
    t.string   "mac_address",             :limit => 45,                                     :null => false
    t.string   "username",                :limit => 45,                                     :null => false
    t.string   "password",                :limit => 45,                                     :null => false
    t.string   "bios_password",           :limit => 45,                                     :null => false
    t.boolean  "deployed",                               :default => false,                 :null => false
    t.string   "timezone",                               :default => "UTC",                 :null => false
  end

  create_table "pxp_hopkins_primary_record_sets", :force => true do |t|
    t.integer  "equipmentID", :limit => 3,                    :null => false
    t.datetime "obs_date",                                    :null => false
    t.datetime "timestamp",                                   :null => false
    t.boolean  "deleted",                  :default => false, :null => false
  end

end
