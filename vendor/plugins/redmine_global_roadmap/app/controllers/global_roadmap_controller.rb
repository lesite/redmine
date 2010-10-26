class GlobalRoadmapController < ApplicationController
  unloadable

  def index
    @versions = Version.find(:all, :include => [:project, :custom_values], :order => "versions.effective_date ASC")
    @versions.reject! { |v| v.completed? }
    @versions = @versions.paginate(:page => params[:page],:per_page=>10)
  end
    
end
