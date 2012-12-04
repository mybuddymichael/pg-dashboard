class IcpMetadataAddDefaultValues < ActiveRecord::Migration
  def up
    change_table :icp_metadata do |t|
      t.change :icp_id, :integer, null: false
      t.change_default :enabled, true
      t.change_default :check_connection, true
      t.change_default :check_parsing, true
      t.change_default :check_syncing, true
    end
  end

  def down
    change_table :icp_metadata do |t|
      t.change :icp_id, :integer, null: true
      t.change_default :enabled, nil
      t.change_default :check_connection, nil
      t.change_default :check_parsing, nil
      t.change_default :check_syncing, nil
    end
  end
end
