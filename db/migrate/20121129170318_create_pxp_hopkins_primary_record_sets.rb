class CreatePxpHopkinsPrimaryRecordSets < ActiveRecord::Migration
  def change
    create_table :pxp_hopkins_primary_record_sets do |t|
      t.integer  "equipmentID", :limit => 3,                    :null => false
      t.datetime "obs_date",                                    :null => false
      t.datetime "timestamp",                                   :null => false
      t.boolean  "deleted",                  :default => false, :null => false
    end
  end
end
