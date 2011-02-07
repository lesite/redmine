class AddClosedAtToIssues < ActiveRecord::Migration

  def self.up
    add_column :issues, :closed_at, :datetime
  end

  def self.down
    remove_column :issues, :closed_at
  end

end