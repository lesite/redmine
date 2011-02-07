class CreateIssueBurndownLog < ActiveRecord::Migration
  def self.up
    create_table :issue_burndown_logs do |t|
      t.column :issues_closed, :integer, :default => 0, :null => false
      t.column :remaining_issues, :integer, :default => 0, :null => false
      t.column :project_id, :integer, :default => 0, :null => false
      t.column :date, :date, :null => false
    end
  end

  def self.down
    drop_table :issue_burndown_logs
  end
end
