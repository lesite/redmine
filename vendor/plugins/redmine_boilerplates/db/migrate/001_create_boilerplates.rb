class CreateBoilerplates < ActiveRecord::Migration
  def self.up
    create_table "boilerplates", :force => true do |t|
      t.integer :tracker_id
      t.text :content
    end
  end

  def self.down
    drop_table "boilerplates"
  end
end

