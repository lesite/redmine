class EstimatedActivityHour < ActiveRecord::Base
  belongs_to :project
  belongs_to :activity
  
  def self.get_hours project_id, activity_id
    hours = find(:first, :conditions => {:project_id => project_id, :activity_id => activity_id }, :select => "hours")
    hours.present? ? hours.hours : nil
  end
  
  def self.qa project_id
    hours = find(:all, :conditions=>{:project_id=>project_id},:select=>"hours")  
    total = 0
    if hours.present?
      hours.map{|x| total = total + x.hours.to_f }
      (total * 0.1).round.to_i
    else 
      nil
    end
  end
  
  def self.management project_id
    self.qa(project_id)
  end
      
  def self.total project_id
     hours = find(:all, :conditions=>{:project_id=>project_id},:select=>"hours")  
      total = 0
      if hours.present?
        hours.map{|x| total = total + x.hours.to_f }
        ((total * 0.1).round.to_i * 2 + total).to_i
      else 
        nil
      end    
  end
  
end