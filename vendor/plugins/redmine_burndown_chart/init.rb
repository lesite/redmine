require 'redmine'

require 'issue_patch'

Dispatcher.to_prepare do
  Issue.send(:include, IssuePatch) unless Issue.included_modules.include? IssuePatch
end

Redmine::Plugin.register :redmine_burndown_chart do
  name 'Redmine Burndown Chart plugin'
  author 'Gordon B. Isnor'
  description 'Google Charts Burndown'
  version '0.0.0.1'
end
