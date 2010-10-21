class CustomFieldAdminOnlyBoolean < ActiveRecord::Migration
  def self.up
    add_column :custom_fields, :admin, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :custom_fields, :admin
  end
end
