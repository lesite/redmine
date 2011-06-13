require 'redmine'

require 'project_patch'
require 'lesite_projects_project_patch'
require 'lesite_enumerations_patch'
require 'lesite_projects_time_entry_activity_patch'

Dispatcher.to_prepare do

  TimeEntryActivity.send(:include, LesiteProjectsTimeEntryActivityPatch) unless Project.included_modules.include? LesiteProjectsTimeEntryActivityPatch


  Project.send(:include, ProjectPatch) unless Project.included_modules.include? ProjectPatch

  Project.send(:include, LesiteProjectsProjectPatch) unless Project.included_modules.include? LesiteProjectsProjectPatch

  Enumeration.send(:include, LesiteEnumerationsPatch) unless Enumeration.included_modules.include? LesiteEnumerationsPatch

end

Redmine::Plugin.register :redmine_lesite_projects do
  name 'Redmine Lesite Projects plugin'
  author 'Gordon B. Isnor'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://www.isnorcreative.com'
end

Project.class_eval do
  has_many :estimated_activity_hours
end