# desc "Explaining what the task does"
# task :redmine_burndown_chart do
#   # Task goes here
# end

desc "Log Closed Issues For The Previous Day Once Each Night"
task :log_closed_issues do
  IssueBurndownLog.log_closed_issues_for_previous_day
end