class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :primary_key => "userID", :force => true do |t|
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

    add_index "users", ["companyID"], :name => "FK_company_id"
    add_index "users", ["username"], :name => "Index_3", :unique => true
  end
end
