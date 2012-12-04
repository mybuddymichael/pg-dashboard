class CreateIcpMetadata < ActiveRecord::Migration
  def change
    create_table :icp_metadata, primary_key: :icp_id do |t|
      t.belongs_to :icp
      t.boolean :enabled
      t.boolean :check_connection
      t.boolean :check_parsing
      t.boolean :check_syncing
    end
  end
end
