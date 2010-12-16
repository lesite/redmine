ActionController::Routing::Routes.draw do |map|
  map.connect 'lesite_projects_update_activities/:project_id', :controller => 'lesite_projects', :action => 'update_activities'
end