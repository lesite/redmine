namespace :redmine_burndown_chart do
  desc "Log Closed Issues For The Previous Day Once Each Night"
  task :log_closed_issues => :environment do
    if IssueBurndownLog.log_closed_issues_for_previous_day
      puts "Burndown Chart updated"
    else
      raise "Burndown Chart failed to update"
    end
  end
end