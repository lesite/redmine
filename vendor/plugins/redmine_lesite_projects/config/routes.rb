ActionController::Routing::Routes.draw do |map|
  map.connect 'lesite_projects_update_activities/:project_id', :controller => 'lesite_projects', :action => 'update_activities'
  map.connect 'lesite_projects/in_place_edit', :controller => "lesite_projects", :action => "in_place_edit"
end