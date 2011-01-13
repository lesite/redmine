class GlobalRoadmapController < ApplicationController
  unloadable

  def index
    @versions = Version.find(:all, :include => [:project, :custom_values], :order => "versions.effective_date IS NULL, versions.effective_date ASC", :conditions => "name NOT LIKE '%%Backlog%%'")
    @versions.reject! { |v| v.completed? }
    @versions = @versions.paginate(:order => "version.effective_date IS NULL, version.effective_date ASC", :page => params[:page], :per_page => 10)
    @active_projects = Project.find(
      :all, 
      :order => "versions.effective_date IS NULL, versions.effective_date ASC, name ASC", 
      :joins => [{ :issues => :status },:versions],
      :conditions => ["#{IssueStatus.table_name}.is_closed = ? AND issues.tracker_id=5", false],
      :group => "projects.id",
      :select => "projects.*"
    )
    
  end
    
end
