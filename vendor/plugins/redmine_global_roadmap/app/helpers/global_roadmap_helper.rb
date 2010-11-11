module GlobalRoadmapHelper

  def link_to_version(version, options = {})
    return '' unless version && version.is_a?(Version)
    link_to_if version.visible?, format_version_name(version), { :controller => 'versions', :action => 'show', :id => version }, options
  end
  
  def get_issues version
    version.fixed_issues.visible.find(:all,
      :include => [:project, :status, :tracker, :priority],
      :conditions => { :project_id => version.project.id },
      :order => "#{Project.table_name}.lft, #{Tracker.table_name}.position, #{Issue.table_name}.id"
      )
  end
    
end