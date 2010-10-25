class GlobalRoadmapController < ApplicationController
  unloadable

  def index
    @projects = Project.visible.find(:all, :include => :trackers, :order => "projects.created_on DESC")
    @items = []
    @projects.map { |project|
      versions, issues_by_version = get_versions(project)
      @items << { :project => project, :versions => versions, :issues_by_version => issues_by_version } if versions.present?
    }
  end
  
  private
    
    def retrieve_selected_tracker_ids(selectable_trackers, default_trackers=nil)
      if ids = params[:tracker_ids]
        (ids.is_a? Array) ? ids.collect { |id| id.to_i.to_s } : ids.split('/').collect { |id| id.to_i.to_s }
      else
        (default_trackers || selectable_trackers).collect {|t| t.id.to_s }
      end
    end
    
    def get_versions project
      trackers = project.trackers 
      selected_tracker_ids = retrieve_selected_tracker_ids(trackers, trackers.select {|t| t.is_in_roadmap?})
      with_subprojects = params[:with_subprojects].nil? ? Setting.display_subprojects_issues? : (params[:with_subprojects] == '1')
      project_ids = with_subprojects ? project.self_and_descendants.collect(&:id) : [project.id]

      versions = project.shared_versions || []
      versions += project.rolled_up_versions.visible if with_subprojects
      versions = versions.uniq.sort
      versions.reject! {|version| version.closed? || version.completed? } unless params[:completed]

      issues_by_version = {}
      unless selected_tracker_ids.empty?
        versions.each do |version|
          issues = version.fixed_issues.visible.find(:all,
                                                     :include => [:project, :status, :tracker, :priority],
                                                     :conditions => {:tracker_id => selected_tracker_ids, :project_id => project_ids},
                                                     :order => "#{Project.table_name}.lft, #{Tracker.table_name}.position, #{Issue.table_name}.id")
          issues_by_version[version] = issues
        end
      end
      versions.reject! {|version| !project_ids.include?(version.project_id) && issues_by_version[version].blank?}
      return [versions, issues_by_version]
    end
  
  
end
