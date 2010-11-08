class GlobalRoadmapController < ApplicationController
  unloadable

  def index
    @versions = Version.find(:all, :include => [:project, :custom_values], :order => "versions.effective_date ASC")
    @versions.reject! { |v| v.completed? }
    @versions = @versions.paginate(:page => params[:page], :per_page => 10)
    @active_projects = Project.find(
      :all, 
      :order => "name ASC", 
      :joins => { :issues => :status },
      :conditions => ["#{IssueStatus.table_name}.is_closed = ? AND issues.tracker_id=5", false],
      :group => "projects.id",
      :select => "projects.*"
    )
    
  end
    
end
