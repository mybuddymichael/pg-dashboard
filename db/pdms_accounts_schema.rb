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

  create_table "company", :primary_key => "companyID", :force => true do |t|
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

  create_table "company_contact_list", :force => true do |t|
    t.integer "company_id",                   :null => false
    t.integer "user_id"
    t.string  "contact_type",  :limit => 45,  :null => false
    t.string  "contact_name",  :limit => 127, :null => false
    t.string  "contact_phone", :limit => 45,  :null => false
    t.string  "contact_email",                :null => false
  end

  add_index "company_contact_list", ["company_id"], :name => "FK_company_contact_list_1"
  add_index "company_contact_list", ["user_id"], :name => "FK_company_contact_list_2"

  create_table "customer_contact_list", :id => false, :force => true do |t|
    t.integer "userID",        :null => false
    t.boolean "correspondent", :null => false
  end

  add_index "customer_contact_list", ["userID"], :name => "FK_customer_contact_list_1"

  create_table "icp_master", :force => true do |t|
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

  add_index "icp_master", ["company_id"], :name => "FK_icp_master_1"
  add_index "icp_master", ["icp_name"], :name => "Index_2", :unique => true

  create_table "icp_tunnel_devices", :force => true do |t|
    t.integer   "icp_id",                                                  :null => false
    t.string    "device_name",                                             :null => false
    t.string    "device_type",            :limit => 20,                    :null => false
    t.string    "device_ip_address",      :limit => 39,                    :null => false
    t.integer   "device_port",            :limit => 2,                     :null => false
    t.string    "username"
    t.string    "password"
    t.integer   "device_tunnel_port",     :limit => 2
    t.integer   "client_tunnel_port",     :limit => 2
    t.boolean   "device_connected",                     :default => false, :null => false
    t.boolean   "client_connected",                     :default => false, :null => false
    t.boolean   "local_client_connected",               :default => false, :null => false
    t.timestamp "last_connect_time",                                       :null => false
    t.text      "resource_path",                                           :null => false
    t.string    "resource_MIME_type",     :limit => 80, :default => "",    :null => false
    t.integer   "resource_width",         :limit => 2,  :default => 0,     :null => false
    t.integer   "resource_height",        :limit => 2,  :default => 0,     :null => false
  end

  add_index "icp_tunnel_devices", ["client_tunnel_port"], :name => "client_tunnel_port_unique", :unique => true
  add_index "icp_tunnel_devices", ["device_tunnel_port"], :name => "device_tunnel_port_unique", :unique => true
  add_index "icp_tunnel_devices", ["icp_id"], :name => "FK_icp_tunnel_device_icp_id"

  create_table "prime_constraint_type", :force => true do |t|
    t.string "constraint_name", :limit => 100, :null => false
  end

  create_table "prime_constraint_type_template", :force => true do |t|
    t.integer "data_source_id",                   :null => false
    t.integer "constraint_type_id",               :null => false
    t.string  "alias",              :limit => 45, :null => false
    t.integer "ordinal_index",      :limit => 1,  :null => false
  end

  add_index "prime_constraint_type_template", ["constraint_type_id"], :name => "FK_prime_constraint_type_template_2"
  add_index "prime_constraint_type_template", ["data_source_id"], :name => "FK_prime_constraint_type_template_1"

  create_table "prime_data_formula_template", :force => true do |t|
    t.integer "data_source_id",                                                 :null => false
    t.string  "group_name",               :limit => 100,                        :null => false
    t.string  "display_name",                                                   :null => false
    t.text    "formula_text",                                                   :null => false
    t.string  "vertical_axis",            :limit => 9,   :default => "Primary", :null => false
    t.integer "color",                                   :default => 0,         :null => false
    t.boolean "show_on_production_plots",                :default => false,     :null => false
    t.boolean "plot_interpolated_values",                :default => false,     :null => false
    t.boolean "show_on_individual_plots",                :default => false,     :null => false
    t.boolean "ignore_zeroes",                           :default => false,     :null => false
    t.string  "aggregation_method",       :limit => 7,   :default => "None",    :null => false
    t.string  "partition_by",                                                   :null => false
    t.string  "time_interval",            :limit => 7,   :default => "Hourly",  :null => false
    t.string  "interpolation_method",     :limit => 10,  :default => "Linear",  :null => false
    t.boolean "is_cumulative",                           :default => false,     :null => false
    t.boolean "is_valid",                                :default => false,     :null => false
  end

  add_index "prime_data_formula_template", ["data_source_id"], :name => "FK_prime_data_formula_template_1"

  create_table "prime_data_source", :force => true do |t|
    t.integer  "company_id",        :null => false
    t.string   "schema_name",       :null => false
    t.string   "name",              :null => false
    t.datetime "create_date",       :null => false
    t.datetime "last_updated_date", :null => false
    t.text     "description",       :null => false
  end

  add_index "prime_data_source", ["company_id"], :name => "FK_prime_data_source_1"
  add_index "prime_data_source", ["schema_name", "name"], :name => "Index_3", :unique => true

  create_table "prime_license_text", :force => true do |t|
    t.date "create_date", :null => false
    t.text "text",        :null => false
  end

  create_table "prime_login_lock", :primary_key => "is_locked", :force => true do |t|
  end

  create_table "prime_map_layers", :primary_key => "ID", :force => true do |t|
    t.string  "Name",                                                     :null => false
    t.string  "FolderName",               :limit => 45,                   :null => false
    t.integer "Priority",                                                 :null => false
    t.integer "OwnerCompany",                                             :null => false
    t.boolean "DefaultCompanyWideAccess",               :default => true, :null => false
  end

  add_index "prime_map_layers", ["FolderName"], :name => "UNIQUE_FolderName", :unique => true
  add_index "prime_map_layers", ["Name"], :name => "UNIQUE_Name", :unique => true
  add_index "prime_map_layers", ["OwnerCompany"], :name => "FK_LayerGroup"
  add_index "prime_map_layers", ["Priority"], :name => "UNIQUE_Priority", :unique => true

  create_table "prime_user_data_formula", :force => true do |t|
    t.integer "user_data_source_id",                                            :null => false
    t.string  "group_name",               :limit => 100,                        :null => false
    t.string  "display_name",                                                   :null => false
    t.string  "formula_key",                                                    :null => false
    t.text    "formula_text",                                                   :null => false
    t.string  "vertical_axis",            :limit => 9,   :default => "Primary", :null => false
    t.integer "color",                                   :default => 0,         :null => false
    t.boolean "show_on_production_plots",                :default => true,      :null => false
    t.boolean "plot_interpolated_values",                :default => false,     :null => false
    t.boolean "show_on_individual_plots",                :default => true,      :null => false
    t.boolean "ignore_zeroes",                           :default => false,     :null => false
    t.string  "aggregation_method",       :limit => 7,   :default => "None",    :null => false
    t.string  "partition_by",                            :default => "",        :null => false
    t.string  "time_interval",            :limit => 7,   :default => "Hourly",  :null => false
    t.string  "interpolation_method",     :limit => 10,  :default => "Linear",  :null => false
    t.boolean "is_cumulative",                           :default => false,     :null => false
    t.boolean "is_valid",                                :default => false,     :null => false
  end

  add_index "prime_user_data_formula", ["formula_key"], :name => "Index_2", :unique => true
  add_index "prime_user_data_formula", ["user_data_source_id"], :name => "FK_prime_user_data_formula_1"

  create_table "prime_user_data_source", :force => true do |t|
    t.integer "user_id",        :null => false
    t.integer "data_source_id", :null => false
  end

  add_index "prime_user_data_source", ["data_source_id"], :name => "FK_prime_user_data_source_1"
  add_index "prime_user_data_source", ["user_id"], :name => "FK_prime_user_data_source_2"

  create_table "prime_user_data_source_constraint", :force => true do |t|
    t.integer "user_data_source_id"
    t.integer "constraint_type_id",                :null => false
    t.string  "alias",               :limit => 45
    t.integer "ordinal_index",       :limit => 1,  :null => false
  end

  add_index "prime_user_data_source_constraint", ["constraint_type_id"], :name => "FK_prime_user_constraints_3"
  add_index "prime_user_data_source_constraint", ["user_data_source_id"], :name => "FK_prime_user_data_source_constraint_4"

  create_table "prime_user_data_source_constraint_restriction", :force => true do |t|
    t.integer "user_data_source_constraint_id", :null => false
    t.string  "constraint_value",               :null => false
  end

  add_index "prime_user_data_source_constraint_restriction", ["user_data_source_constraint_id"], :name => "FK_user_constraints_1"

  create_table "prime_user_feedback", :force => true do |t|
    t.datetime "date",                  :null => false
    t.integer  "userID",                :null => false
    t.string   "type",    :limit => 14, :null => false
    t.text     "message",               :null => false
  end

  add_index "prime_user_feedback", ["userID"], :name => "FK_prime_user_feedback_1"

  create_table "prime_user_group_history", :force => true do |t|
    t.integer   "parent_group_id"
    t.integer   "user_data_source_id",                :null => false
    t.integer   "session_id",                         :null => false
    t.string    "group_hash",          :limit => 45,  :null => false
    t.string    "group_name",          :limit => 100, :null => false
    t.timestamp "start_date",                         :null => false
    t.datetime  "end_date"
  end

  add_index "prime_user_group_history", ["group_hash"], :name => "Index_4", :unique => true
  add_index "prime_user_group_history", ["parent_group_id"], :name => "FK_prime_user_group_history_2"
  add_index "prime_user_group_history", ["session_id"], :name => "FK_prime_user_session_group_2"
  add_index "prime_user_group_history", ["user_data_source_id"], :name => "FK_prime_user_group_history_3"

  create_table "prime_user_group_query", :force => true do |t|
    t.integer   "group_id",   :null => false
    t.timestamp "query_date", :null => false
    t.text      "query_text", :null => false
  end

  add_index "prime_user_group_query", ["group_id"], :name => "FK_prime_user_group_query_3"

  create_table "prime_user_map_constraints", :primary_key => "Index", :force => true do |t|
    t.string  "RuleType",   :limit => 10,                    :null => false
    t.boolean "Inclusive",                                   :null => false
    t.integer "UserID"
    t.integer "CompanyID"
    t.integer "MapLayerID",                                  :null => false
    t.boolean "Visibility",               :default => false, :null => false
    t.boolean "Disabled",                 :default => false, :null => false
  end

  add_index "prime_user_map_constraints", ["CompanyID"], :name => "FK_companyID_001"
  add_index "prime_user_map_constraints", ["MapLayerID"], :name => "FK_map_layer_001"
  add_index "prime_user_map_constraints", ["UserID"], :name => "FK_userID_001"

  create_table "prime_user_session_history", :force => true do |t|
    t.integer   "user_id",                                          :null => false
    t.string    "session_hash",   :limit => 100,                    :null => false
    t.timestamp "start_date",                                       :null => false
    t.datetime  "end_date"
    t.boolean   "was_terminated",                :default => false, :null => false
  end

  add_index "prime_user_session_history", ["session_hash"], :name => "Index_3", :unique => true
  add_index "prime_user_session_history", ["user_id"], :name => "FK_user_session_history_1"

  create_table "prime_version_information", :force => true do |t|
    t.integer  "major",                                              :null => false
    t.integer  "minor",                                              :null => false
    t.integer  "build"
    t.integer  "revision",                                           :null => false
    t.string   "sha_key",     :limit => 40,                          :null => false
    t.datetime "timestamp",                                          :null => false
    t.text     "build_notes",                                        :null => false
    t.string   "author",      :limit => 45,                          :null => false
    t.string   "build_type",  :limit => 10, :default => "Developer", :null => false
    t.boolean  "valid",                     :default => true,        :null => false
    t.integer  "license_id",                :default => 1,           :null => false
  end

  add_index "prime_version_information", ["license_id"], :name => "FK_versions_1"

  create_table "products", :primary_key => "productID", :force => true do |t|
    t.string "productName", :limit => 45, :null => false
  end

  create_table "referrals", :primary_key => "referralID", :force => true do |t|
    t.string "referralName", :limit => 50, :null => false
  end

  create_table "system_check_categories", :force => true do |t|
    t.string  "category",    :limit => 45, :null => false
    t.integer "order_index",               :null => false
  end

  add_index "system_check_categories", ["category"], :name => "task_category_unique_check", :unique => true

  create_table "system_check_client_subgroups", :force => true do |t|
    t.integer "client_company_id", :null => false
    t.string  "subgroup_name"
  end

  add_index "system_check_client_subgroups", ["client_company_id"], :name => "FK_system_check_clients_1"

  create_table "system_check_records", :force => true do |t|
    t.integer   "task_id",   :null => false
    t.integer   "user_id",   :null => false
    t.timestamp "timestamp", :null => false
  end

  add_index "system_check_records", ["task_id"], :name => "FK_system_check_records_2"
  add_index "system_check_records", ["user_id"], :name => "FK_system_check_records_1"

  create_table "system_check_tasks", :force => true do |t|
    t.integer "client_id",                                                           :null => false
    t.integer "task_category",                                                       :null => false
    t.string  "task_description",                                                    :null => false
    t.integer "task_frequency",   :limit => 2,  :default => 1,                       :null => false
    t.integer "order_index",      :limit => 2,  :default => 1,                       :null => false
    t.string  "skill_level",      :limit => 21, :default => "Programming Knowledge", :null => false
    t.boolean "enabled",                        :default => true,                    :null => false
  end

  add_index "system_check_tasks", ["client_id"], :name => "fk_task_client_id"
  add_index "system_check_tasks", ["task_category"], :name => "fk_task_category_id"

  create_table "system_check_users", :primary_key => "user_id", :force => true do |t|
  end

  create_table "user", :primary_key => "userID", :force => true do |t|
    t.integer "companyID",                    :default => 1,     :null => false
    t.string  "username",       :limit => 45,                    :null => false
    t.string  "password",       :limit => 40,                    :null => false
    t.string  "firstName",      :limit => 45,                    :null => false
    t.string  "lastName",       :limit => 45,                    :null => false
    t.string  "email",          :limit => 45,                    :null => false
    t.string  "phone",          :limit => 45,                    :null => false
    t.string  "title"
    t.string  "role",           :limit => 13,                    :null => false
    t.boolean "enabled",                      :default => false, :null => false
    t.boolean "verified",                     :default => false, :null => false
    t.boolean "emailVerified",                :default => false, :null => false
    t.integer "licenseVersion",               :default => 0,     :null => false
    t.date    "licenseDate"
    t.date    "expirationDate"
  end

  add_index "user", ["companyID"], :name => "FK_company_id"
  add_index "user", ["username"], :name => "Index_3", :unique => true

  create_table "user_interests", :primary_key => "index", :force => true do |t|
    t.integer "userID",    :null => false
    t.integer "productID", :null => false
  end

  add_index "user_interests", ["productID"], :name => "FK_productID"
  add_index "user_interests", ["userID"], :name => "FK_userID"

  create_table "user_referrals", :primary_key => "index", :force => true do |t|
    t.integer "userID",     :null => false
    t.integer "referralID", :null => false
  end

  add_index "user_referrals", ["referralID"], :name => "FK_referralID"
  add_index "user_referrals", ["userID"], :name => "FK_referralUserID"

end
