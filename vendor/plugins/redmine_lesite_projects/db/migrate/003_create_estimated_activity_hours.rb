class CreateEstimatedActivityHours< ActiveRecord::Migration
  def self.up
    create_table "estimated_activity_hours", :force => true do |t|
      t.integer :project_id
      t.integer :activity_id
      t.string  :hours, :limit => 6
    end
  end
  
  def self.down
    drop_table "estimated_activity_hours"
  end
  
end