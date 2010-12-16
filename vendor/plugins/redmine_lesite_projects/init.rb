require 'redmine'

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