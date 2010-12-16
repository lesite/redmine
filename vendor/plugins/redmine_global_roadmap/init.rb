# Include hook code here
require 'redmine'

Redmine::Plugin.register :redmine_global_roadmap do
  name 'Redmine Global Roadmap plugin'
  author 'Gordon B. Isnor'
  description 'This Redmine plugin provides a global view of all projects. '
  version '0.0.0.1'

  # Configuring permissions for plugin's controllers.
  project_module :redmine_global_roadmap do
    permission :view_global_roadmap, { :global_roadmap => [:index] }, :public => true
  end
 
  # Creating menu entry. It appears in project menu as the last entry.
  menu :top_menu, :global_roadmap, { :controller => 'global_roadmap', :action => 'index' }, :caption => :global_roadmap
end

