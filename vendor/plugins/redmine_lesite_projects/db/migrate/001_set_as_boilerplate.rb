class SetAsBoilerplate < ActiveRecord::Migration
  def self.up
    add_column :projects, :boilerplate, :boolean, :default => false
  end

  def self.down
    remove_column :projects, :boilerplate
  end
end

