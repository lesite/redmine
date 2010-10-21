# Include hook code here
require 'redmine'

Redmine::Plugin.register :redmine_global_project_view do
  name 'Redmine Global Project View plugin'
  author 'Gordon B. Isnor'
  description 'This Redmine plugin provides a global view of all projects. '
  version '0.0.0.1'

  # Configuring permissions for plugin's controllers.
  project_module :redmine_global_project_view do
    permission :view_global_project_view, { :global_project_view => [:index] }, :public => true
  end
 
  # Creating menu entry. It appears in project menu as the last entry.
  menu :global_project_view, :global_project_view, { :controller => 'global_project_view', :action => 'index' }, :caption => :global_project_view, :last => true
end


require 'redmine'

Redmine::Plugin.register :redmine_bugcloud do
  name 'Redmine Bugcloud plugin'
  author 'Maedana'
  description 'This Redmine plugin visualizes the issues of a project as an issue cloud. '
  version '0.0.2.1'

  # Configuring permissions for plugin's controllers.
  project_module :bugcloud do
    permission :view_bugcloud, { :bugcloud => [:index] }, :public => true
  end
   
  menu :top_menu, :global_project_view, { :controller => 'global_project_view', :action => 'index', :project_id => nil, :user_id => nil }, :after => :home, :caption => :global_project_view
	
  
end
