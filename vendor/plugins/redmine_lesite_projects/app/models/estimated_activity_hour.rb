class EstimatedActivityHour < ActiveRecord::Base
  belongs_to :project
  belongs_to :activity
  
  def self.get_hours project_id, activity_id
    hours = find(:first, :conditions => {:project_id => project_id, :activity_id => activity_id }, :select => "hours")
    hours.present? ? hours.hours.to_f : 0
  end
    
  def self.used project, activity
    TimeEntry.sum(:hours,:conditions=>{:project_id=>project.id,:activity_id=>activity.id}).to_f.round
  end
  
  def self.used_over_estimated project, activity
    used = EstimatedActivityHour.used(project,activity)
    est = EstimatedActivityHour.get_hours(project.id, activity.id)
    "#{used} / <strong>#{est.ceil.to_i}</strong>"
  end
      
  def self.total project_id
     hours = find(:all, :conditions=>{:project_id=>project_id},:select=>"hours")  
      total = 0
      if hours.present?
        hours.map{|x| total = total + x.hours.to_f }
        return total.round
      else 
        0
      end    
  end
  
  def self.total_used project
    t = TimeEntry.sum(:hours,:conditions=>{:project_id=>project.id}).to_f.round
    t.present? ? t : 0
  end
  
  def self.total_overbudget? project
    self.total_used(project) > self.total(project.id)
  end
  
  def self.overbudget? project, activity
    used = EstimatedActivityHour.used(project,activity)
    est = EstimatedActivityHour.get_hours(project.id, activity.id)
    used > est
  end
  
  def self.total_used_over_estimated project
    "#{self.total_used(project)} / <strong>#{self.total(project.id)}</strong>"
  end
  
end