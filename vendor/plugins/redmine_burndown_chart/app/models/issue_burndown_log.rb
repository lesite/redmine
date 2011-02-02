class IssueBurndownLog < ActiveRecord::Base
  belongs_to :project

  # CREATE LOGS -- rake task should be run by cron nightly
  def self.log_closed_issues_for_previous_day
    projects = Project.find(:all)
    projects.each do |project|
      existing = IssueBurndownLog.find(:first, :conditions => { :project_id => project.id, :date => Date.yesterday })
      if existing.blank?
        issues_closed_yesterday = Issue.count(:conditions => ["closed_at = '#{Date.yesterday.to_s(:mysql)}' AND project_id = ?", project.id])
        closed_issued_total = Issue.count(:conditions=>["closed_at < ? AND project_id = ?", Date.today, project.id])
        remaining_issues = project.issues.count - closed_issued_total
        IssueBurndownLog.create({:project_id => project.id, :issues_closed => issues_closed_yesterday, :date => Date.yesterday, :remaining_issues => remaining_issues })
      end
    end
  end
  
  # FOR THE LAST 30 DAYS FOR BAR GRAPH
  def self.issues_closed_in_last_thirty_days project_id, days
    issues = IssueBurndownLog.find(:all, :select => "issues_closed",:conditions => ["date >= DATE_SUB(CURRENT_DATE(), INTERVAL #{days} DAY) AND project_id = ?", project_id], :order=>"date ASC")
    array = issues.map {|i| i.issues_closed }
    if array.size < days
      rev = array.reverse
      (days - array.size).times do
        rev << 0
      end
      return rev.reverse
    else
      return array
    end  
  end
  
  # FOR THE LINE GRAPH OF REMAINING ISSUES PER LAST 30 DAYS
  def self.issues_remaining_in_last_thirty_days project_id, days
      issues = IssueBurndownLog.find(:all, :select => "remaining_issues",:conditions => ["date >= DATE_SUB(CURRENT_DATE(), INTERVAL #{days} DAY) AND project_id = ?", project_id], :order => "date ASC")
      array = issues.map {|i| i.remaining_issues }
      if array.size < days
        rev = array.reverse
        (days - array.size).times do
          rev << 0
        end
        return rev.reverse
      else
        return array
      end
  end  
  
end