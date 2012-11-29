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

ActiveRecord::Schema.define(:version => 0) do

  create_table "Record_Tracker", :id => false, :force => true do |t|
    t.integer   "RecID"
    t.integer   "EquipID",   :limit => 3,                    :null => false
    t.datetime  "obs_date",                                  :null => false
    t.string    "Status",    :limit => 6, :default => "New", :null => false
    t.timestamp "timestamp",                                 :null => false
  end

  add_index "Record_Tracker", ["EquipID"], :name => "Record_Tracker_index01"
  add_index "Record_Tracker", ["RecID"], :name => "RT_idx03"
  add_index "Record_Tracker", ["obs_date"], :name => "Record_Tracker_index02"

  create_table "config_main_acknowledge_dataview", :force => true do |t|
    t.string "filename",           :limit => 45,  :null => false
    t.string "description",        :limit => 100, :null => false
    t.string "tagname",            :limit => 45,  :null => false
    t.string "datatype",           :limit => 45,  :null => false
    t.string "reference_dataview", :limit => 45,  :null => false
  end

  create_table "config_main_aggregate_rules", :force => true do |t|
    t.string  "db_table",        :limit => 50,                   :null => false
    t.string  "db_column",       :limit => 50,                   :null => false
    t.integer "hourly_lifespan", :limit => 3,                    :null => false
    t.integer "daily_lifespan",  :limit => 3,                    :null => false
    t.boolean "enabled",                       :default => true, :null => false
  end

  create_table "config_main_alarm_mapping", :force => true do |t|
    t.string  "data_source",   :limit => 25, :null => false
    t.string  "tag_name",      :limit => 75, :null => false
    t.integer "equipment_id",  :limit => 2,  :null => false
    t.integer "alarm_code_id", :limit => 2,  :null => false
    t.integer "severity",      :limit => 2,  :null => false
    t.string  "details"
  end

  create_table "config_main_dataview_special_tag_rules", :primary_key => "RuleID", :force => true do |t|
    t.integer "DataviewID", :null => false
    t.integer "TagType",    :null => false
  end

  add_index "config_main_dataview_special_tag_rules", ["DataviewID"], :name => "FK_config_main_dataview_special_tag_rules_DataviewID"
  add_index "config_main_dataview_special_tag_rules", ["TagType"], :name => "FK_config_main_dataview_special_tag_rules_tag_types"

  create_table "config_main_dataviews", :force => true do |t|
    t.string  "filename",     :limit => 45,                            :null => false
    t.string  "dataviewType", :limit => 45,  :default => "historical", :null => false
    t.integer "frequency",                   :default => 600,          :null => false
    t.string  "ipaddress",    :limit => 39,                            :null => false
    t.string  "username",     :limit => 25,                            :null => false
    t.string  "password",     :limit => 25,                            :null => false
    t.string  "description",  :limit => 100,                           :null => false
    t.boolean "active",                      :default => true,         :null => false
    t.integer "sourcedevice",                                          :null => false
  end

  add_index "config_main_dataviews", ["sourcedevice"], :name => "FK_sourcedevice_dataviews"

  create_table "config_main_date_tag_extra_data", :primary_key => "tagID", :force => true do |t|
    t.string "format", :limit => 45, :null => false
  end

  add_index "config_main_date_tag_extra_data", ["tagID"], :name => "FK_config_main_plc_date_tag_extra_data_1"

  create_table "config_main_element_placement", :primary_key => "rule_id", :force => true do |t|
    t.integer "page_element_id",                                      :null => false
    t.string  "page_name",                                            :null => false
    t.string  "page_element_parent",                                  :null => false
    t.boolean "prepend_on_insert",                 :default => false, :null => false
    t.boolean "active",                            :default => true,  :null => false
    t.string  "category",            :limit => 45, :default => "%",   :null => false
    t.string  "user_level",          :limit => 13, :default => "%",   :null => false
  end

  add_index "config_main_element_placement", ["page_element_id"], :name => "FK_config_main_element_placement"

  create_table "config_main_page_elements", :force => true do |t|
    t.text   "html",                  :null => false
    t.string "description",           :null => false
    t.string "associated_stylesheet", :null => false
    t.string "associated_script",     :null => false
  end

  create_table "config_main_plc_integer_tag_extra_data", :primary_key => "tagID", :force => true do |t|
    t.integer "size",   :limit => 2, :null => false
    t.boolean "signed",              :null => false
  end

  add_index "config_main_plc_integer_tag_extra_data", ["tagID"], :name => "fk_config_main_plc_integer_tag_meta_data"

  create_table "config_main_plc_progauge_transfer_buffer_tags", :id => false, :force => true do |t|
    t.integer "transfer_buffer_id", :limit => 8, :null => false
    t.integer "tag_id",                          :null => false
  end

  add_index "config_main_plc_progauge_transfer_buffer_tags", ["tag_id"], :name => "config_main_plc_progauge_transfer_buffer_tags_tag_ID_UNIQUE", :unique => true
  add_index "config_main_plc_progauge_transfer_buffer_tags", ["transfer_buffer_id"], :name => "fk_config_main_plc_progauge_transfer_buffer_tags"

  create_table "config_main_plc_progauge_transfer_buffers", :force => true do |t|
    t.integer "PLC_equipment_ID",                    :limit => 3,                    :null => false
    t.integer "transfer_number_tag_id",                                              :null => false
    t.string  "transfer_number_confirmation_tag",    :limit => 80,                   :null => false
    t.string  "transfer_number_acknowledgement_tag", :limit => 80,                   :null => false
    t.integer "observation_date_tag"
    t.boolean "enabled",                                           :default => true, :null => false
  end

  add_index "config_main_plc_progauge_transfer_buffers", ["transfer_number_tag_id"], :name => "transfer_number_tag_id_UNIQUE", :unique => true

  create_table "config_main_reports", :force => true do |t|
    t.string   "report_name",         :limit => 45,                   :null => false
    t.text     "report_query",                                        :null => false
    t.integer  "generate_interval",                 :default => 5,    :null => false
    t.datetime "last_generated"
    t.boolean  "enabled",                           :default => true, :null => false
    t.string   "category",            :limit => 45
    t.integer  "last_execution_time", :limit => 3
  end

  add_index "config_main_reports", ["report_name"], :name => "config_main_reports_report_name_UNIQUE", :unique => true

  create_table "config_main_schedule", :id => false, :force => true do |t|
    t.string    "icp_name",         :limit => 120,                                    :null => false
    t.datetime  "appointment_time"
    t.timestamp "last_sync_time",                  :default => '2009-01-01 00:00:00', :null => false
    t.timestamp "last_parse_time",                 :default => '2009-01-01 00:00:00', :null => false
  end

  create_table "config_main_source_devices", :primary_key => "equipment_id", :force => true do |t|
    t.string  "description",                                         :null => false
    t.string  "package",                                             :null => false
    t.string  "type",                                                :null => false
    t.string  "ip_address",          :limit => 39,                   :null => false
    t.integer "port",                :limit => 2,  :default => 80,   :null => false
    t.string  "username",                          :default => "",   :null => false
    t.string  "password",                          :default => "",   :null => false
    t.boolean "active",                            :default => true, :null => false
    t.text    "additional_settings",                                 :null => false
  end

  create_table "config_main_tag_equipment_relationships", :force => true do |t|
    t.integer "tag_id",                            :null => false
    t.integer "sensor_equipment_id",  :limit => 3
    t.integer "storage_equipment_id", :limit => 3, :null => false
  end

  add_index "config_main_tag_equipment_relationships", ["tag_id", "sensor_equipment_id", "storage_equipment_id"], :name => "UNIQUE_tag_equipment_relationships", :unique => true
  add_index "config_main_tag_equipment_relationships", ["tag_id"], :name => "FK_config_main_tag_equipment_relationships_tag_id"

  create_table "config_main_tag_mapping", :force => true do |t|
    t.string  "data_source",        :limit => 50,                   :null => false
    t.string  "tag_name",           :limit => 75,                   :null => false
    t.string  "friendly_tag_name",  :limit => 50,                   :null => false
    t.string  "friendly_unit_name", :limit => 20,                   :null => false
    t.string  "datatype",           :limit => 7,                    :null => false
    t.integer "equipmentID",        :limit => 2,                    :null => false
    t.string  "db_table",           :limit => 50,                   :null => false
    t.string  "db_column",          :limit => 50,                   :null => false
    t.integer "tag_order",          :limit => 2,  :default => 0,    :null => false
    t.string  "tag_notes",                        :default => "",   :null => false
    t.boolean "insert_tag",                       :default => true, :null => false
    t.integer "frequency",                                          :null => false
  end

  add_index "config_main_tag_mapping", ["db_column"], :name => "__TagMapping_index02"
  add_index "config_main_tag_mapping", ["db_table"], :name => "config_main_tag_mapping_index01"
  add_index "config_main_tag_mapping", ["equipmentID"], :name => "__TagMapping_index01"

  create_table "config_main_tank_reports", :force => true do |t|
    t.integer "equipid",     :limit => 3, :null => false
    t.string  "description",              :null => false
  end

  add_index "config_main_tank_reports", ["equipid"], :name => "UNIQUE_tank_reports_equipid", :unique => true

  create_table "sync_icp_alarm_clearing", :force => true do |t|
    t.integer   "alarm_id",            :limit => 8, :null => false
    t.integer   "alarm_clear_code_id",              :null => false
    t.timestamp "start_date",                       :null => false
    t.timestamp "end_date",                         :null => false
    t.integer   "user_id",                          :null => false
    t.string    "comment"
  end

  add_index "sync_icp_alarm_clearing", ["alarm_id"], :name => "FK_sync_icp_alarm_clearing_1"

  create_table "sync_icp_alarm_details", :force => true do |t|
    t.integer   "equipment_id",  :limit => 2,  :null => false
    t.datetime  "start_date",                  :null => false
    t.datetime  "end_date"
    t.string    "alarm_source",  :limit => 45, :null => false
    t.integer   "alarm_code_id", :limit => 2,  :null => false
    t.integer   "severity",      :limit => 2,  :null => false
    t.string    "notes"
    t.string    "notes_author",  :limit => 45
    t.timestamp "date_updated",                :null => false
  end

  create_table "sync_icp_automatic_records", :force => true do |t|
    t.integer "record_id", :limit => 8, :null => false
    t.integer "tag_id",                 :null => false
    t.string  "value",                  :null => false
  end

  add_index "sync_icp_automatic_records", ["record_id"], :name => "FK_sync_icp_automatic_records_1"
  add_index "sync_icp_automatic_records", ["tag_id"], :name => "FK_sync_icp_automatic_records_2"

  create_table "sync_icp_errors", :force => true do |t|
    t.datetime "ErrorTimeStamp", :null => false
    t.text     "ErrorStrg",      :null => false
  end

  create_table "sync_icp_event_end", :force => true do |t|
    t.integer  "start_id", :limit => 8, :null => false
    t.datetime "end_date",              :null => false
  end

  add_index "sync_icp_event_end", ["start_id"], :name => "fk_event_end"

  create_table "sync_icp_event_start", :force => true do |t|
    t.integer  "equipment_id",  :limit => 3, :null => false
    t.datetime "start_date",                 :null => false
    t.integer  "event_type_id", :limit => 1, :null => false
    t.string   "notes"
    t.string   "notes_author"
  end

  create_table "sync_icp_manual_records", :force => true do |t|
    t.integer "record_id", :limit => 8, :null => false
    t.integer "tag_id",                 :null => false
    t.integer "user_id"
    t.string  "value",                  :null => false
  end

  add_index "sync_icp_manual_records", ["record_id"], :name => "FK_sync_icp_manual_records_1"
  add_index "sync_icp_manual_records", ["tag_id"], :name => "FK_sync_icp_manual_records_2"

  create_table "sync_icp_modified_record_sets", :force => true do |t|
    t.integer   "record_id",  :limit => 8,                    :null => false
    t.integer   "user_id",                                    :null => false
    t.timestamp "timestamp",                                  :null => false
    t.boolean   "deleted",                 :default => false, :null => false
    t.boolean   "reconciled",              :default => true,  :null => false
  end

  add_index "sync_icp_modified_record_sets", ["record_id"], :name => "FK_sync_icp_modified_record_sets_1"

  create_table "sync_icp_modified_records", :force => true do |t|
    t.integer "modification_id", :limit => 8,                    :null => false
    t.integer "tag_id",                                          :null => false
    t.string  "old_value"
    t.string  "new_value"
    t.boolean "processed",                    :default => false, :null => false
  end

  add_index "sync_icp_modified_records", ["modification_id"], :name => "FK_sync_icp_modified_records_1"
  add_index "sync_icp_modified_records", ["tag_id"], :name => "FK_sync_icp_modified_records_2"

  create_table "sync_icp_pending_abandonments", :force => true do |t|
    t.integer   "equipment_id",     :limit => 3,  :null => false
    t.timestamp "abandonment_date",               :null => false
    t.boolean   "abandon",                        :null => false
    t.string    "reason",           :limit => 45, :null => false
  end

  create_table "sync_icp_record_set", :force => true do |t|
    t.integer  "equipmentID", :limit => 3,                    :null => false
    t.datetime "obs_date",                                    :null => false
    t.datetime "timestamp",                                   :null => false
    t.boolean  "deleted",                  :default => false, :null => false
  end

  create_table "sync_main_alarm_clear_codes", :id => false, :force => true do |t|
    t.integer "id",                        :default => 0, :null => false
    t.string  "description", :limit => 50,                :null => false
  end

  create_table "sync_main_alarm_codes", :id => false, :force => true do |t|
    t.integer "id",          :limit => 1,  :default => 0, :null => false
    t.string  "description", :limit => 35,                :null => false
    t.integer "time_buffer",               :default => 0, :null => false
  end

  create_table "sync_main_company", :id => false, :force => true do |t|
    t.integer "companyID",                  :default => 0,     :null => false
    t.string  "companyName",  :limit => 45,                    :null => false
    t.string  "address1",                                      :null => false
    t.string  "address2",     :limit => 45,                    :null => false
    t.string  "city",         :limit => 45,                    :null => false
    t.string  "state",        :limit => 45,                    :null => false
    t.string  "zip",          :limit => 10,                    :null => false
    t.string  "companyEmail", :limit => 45,                    :null => false
    t.string  "companyPhone", :limit => 45,                    :null => false
    t.boolean "verified",                   :default => false, :null => false
  end

  create_table "sync_main_dataview_source_devices", :primary_key => "ID", :force => true do |t|
    t.string "Description", :limit => 140, :null => false
    t.string "PHPName",     :limit => 60,  :null => false
  end

  create_table "sync_main_dataview_tag_types", :primary_key => "ID", :force => true do |t|
    t.string "Name",        :limit => 45, :null => false
    t.string "Description",               :null => false
  end

  create_table "sync_main_equipment", :id => false, :force => true do |t|
    t.integer "id",                 :limit => 3,  :default => 0, :null => false
    t.integer "parent_id",          :limit => 3
    t.string  "equipment_category", :limit => 45,                :null => false
    t.string  "equipment_type",     :limit => 45,                :null => false
    t.string  "equip_name",         :limit => 45,                :null => false
    t.string  "description",                                     :null => false
  end

  create_table "sync_main_equipment_relationship_indexes", :id => false, :force => true do |t|
    t.integer "relationship_id", :limit => 8, :null => false
    t.integer "ordinal_index",   :limit => 2, :null => false
    t.string  "description",                  :null => false
  end

  create_table "sync_main_equipment_relationships", :id => false, :force => true do |t|
    t.integer  "id",                  :limit => 8, :default => 0, :null => false
    t.integer  "parent_equipment_id", :limit => 3,                :null => false
    t.integer  "child_equipment_id",  :limit => 3,                :null => false
    t.datetime "start_date",                                      :null => false
    t.datetime "end_date"
  end

  create_table "sync_main_event_types", :id => false, :force => true do |t|
    t.integer "event_type_id",   :limit => 1, :default => 0, :null => false
    t.string  "event_type_name",                             :null => false
    t.integer "status_id",       :limit => 1,                :null => false
    t.integer "priority",        :limit => 1, :default => 1, :null => false
  end

  create_table "sync_main_meter_types", :id => false, :force => true do |t|
    t.string "TypeName", :null => false
  end

  create_table "sync_main_process_elements", :id => false, :force => true do |t|
    t.integer "id",                  :limit => 3,  :default => 0, :null => false
    t.string  "process_name",        :limit => 30,                :null => false
    t.string  "process_description"
    t.string  "process_owner",       :limit => 20
    t.integer "equipment_id",        :limit => 3,                 :null => false
    t.integer "process_order",       :limit => 2,  :default => 0, :null => false
    t.integer "order_index",         :limit => 1,  :default => 0, :null => false
  end

  create_table "sync_main_status_types", :id => false, :force => true do |t|
    t.integer "status_id",   :limit => 1, :default => 0, :null => false
    t.string  "status_name",                             :null => false
  end

  create_table "sync_main_steam_schedule", :primary_key => "Index", :force => true do |t|
    t.string  "Well_Name",                 :null => false
    t.float   "Steam_Volume",              :null => false
    t.float   "Steam_Rate",                :null => false
    t.date    "Start_Date",                :null => false
    t.date    "End_Date",                  :null => false
    t.integer "Soak_Period",  :limit => 1, :null => false
  end

  create_table "sync_main_tank_details", :id => false, :force => true do |t|
    t.integer "equipid",  :limit => 3,  :null => false
    t.string  "type",     :limit => 45, :null => false
    t.float   "height",                 :null => false
    t.float   "diameter",               :null => false
  end

  create_table "sync_main_tunnel_devices", :id => false, :force => true do |t|
    t.string    "device_name",                                             :null => false
    t.string    "device_type",            :limit => 20,                    :null => false
    t.string    "device_ip_address",      :limit => 39,                    :null => false
    t.integer   "device_port",            :limit => 2,                     :null => false
    t.string    "username"
    t.string    "password"
    t.integer   "device_tunnel_port",     :limit => 2
    t.boolean   "device_connected",                     :default => false, :null => false
    t.boolean   "client_connected",                     :default => false, :null => false
    t.boolean   "local_client_connected",               :default => false, :null => false
    t.timestamp "last_connect_time",                                       :null => false
    t.text      "resource_path",                                           :null => false
    t.string    "resource_MIME_type",     :limit => 80, :default => "",    :null => false
    t.integer   "resource_width",         :limit => 2,  :default => 0,     :null => false
    t.integer   "resource_height",        :limit => 2,  :default => 0,     :null => false
  end

  create_table "sync_main_user", :id => false, :force => true do |t|
    t.integer "userID",                  :default => 0,     :null => false
    t.integer "companyID",               :default => 1,     :null => false
    t.string  "username",  :limit => 45,                    :null => false
    t.string  "password",  :limit => 40,                    :null => false
    t.string  "firstName", :limit => 45,                    :null => false
    t.string  "lastName",  :limit => 45,                    :null => false
    t.string  "email",     :limit => 45,                    :null => false
    t.string  "phone",     :limit => 45,                    :null => false
    t.string  "role",      :limit => 13,                    :null => false
    t.boolean "enabled",                 :default => false, :null => false
    t.boolean "verified",                :default => false, :null => false
  end

end
