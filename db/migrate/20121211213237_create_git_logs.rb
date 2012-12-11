class CreateGitLogs < ActiveRecord::Migration
  def change
    create_table :git_logs do |t|
      t.string :sha
      t.string :message
      t.string :author
      t.date :commit_time
      t.string :branch

      t.timestamps
    end
  end
end
