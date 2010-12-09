require 'redmine'

Redmine::Plugin.register :redmine_add_schedule_link do
  name 'Redmine Add Schedule Link plugin'
  author 'Gordon Isnor'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  author_url 'http://www.isnorcreative.com'
  menu :top_menu, :all_schedules, {:controller => 'schedules', :action => 'index'}, :caption => "Schedules"
end



