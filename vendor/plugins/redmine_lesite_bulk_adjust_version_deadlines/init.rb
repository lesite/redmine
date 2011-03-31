require 'redmine'
require 'redmine_lesite_bulk_adjust_version_deadlines_version_patch'

Dispatcher.to_prepare do
  Version.send(:include, RedmineLesiteBulkAdjustVersionDeadlinesVersionPatch) unless Version.included_modules.include? RedmineLesiteBulkAdjustVersionDeadlinesVersionPatch
end

Redmine::Plugin.register :redmine_lesite_bulk_adjust_version_deadlines do
  name 'Redmine Lesite Bulk Adjust Version Deadlines plugin'
  author 'Gordon B. Isnor'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://www.isnorcreative.com'
end

