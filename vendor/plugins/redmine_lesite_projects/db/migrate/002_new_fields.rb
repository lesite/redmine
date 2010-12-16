class NewFields < ActiveRecord::Migration
  def self.up
    add_column :projects, :deadline, :date
    add_column :projects, :phase, :string, :limit => 20
    add_column :projects, :notes, :string
  end

  def self.down
    remove_column :projects, :notes
    remove_column :projects, :phase
    remove_column :projects, :deadline
  end
end

