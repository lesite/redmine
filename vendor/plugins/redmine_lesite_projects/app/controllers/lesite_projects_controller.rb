class LesiteProjectsController < ApplicationController  
  unloadable
  before_filter :find_project_by_project_id, :except => :in_place_edit
    
  def in_place_edit
    if params[:id][0,6] == "budget" 
      in_place_edit_budgets
    else
      target = params[:id].split("_")[0]
      id = params[:id].split("_")[1]
      @project = Project.find(id)
      @project.update_attribute(target,params[:value])
      if target == 'deadline'
        in_place_edit_deadline
      else
        render :text => @project.send(target)
      end
    end
  end  
    
  def update_activities
    if request.put? && params[:enumerations]
      Project.transaction do
        params[:enumerations].each do |id, activity|
          @project.update_or_create_time_entry_activity(id, activity)
        end
      end
      
      update_activity_hours
      
      flash[:notice] = l(:notice_successful_update)
    end
    redirect_to :controller => 'projects', :action => 'settings', :tab => 'activities', :id => @project
  end
  
  def update_activity_hours
    params[:activity_hours].each_pair do |key,value|
      existing = EstimatedActivityHour.find(:first, :conditions=>{:project_id=>@project.id,:activity_id => key})
      if value.present?
        if existing.present?
          existing.update_attribute("hours",value)
        else
          EstimatedActivityHour.create(:project_id => @project.id, :activity_id => key, :hours => value) 
        end
      else
        existing.destroy if existing.present?
      end
    end
  end
  
  private
  
    def in_place_edit_budgets
      project_id =  params[:id].split("project_")[1]
      activity_id = params[:id].split("_project")[0].split("budget_")[1]
      val = params[:value]
      existing = EstimatedActivityHour.find(:first, :conditions=>{:project_id=>project_id,:activity_id => activity_id})
     if existing.present?
        existing.update_attribute("hours",val)
      else
        EstimatedActivityHour.create(:project_id => project_id, :activity_id => activity_id, :hours => val) 
      end
      render :text => params[:value]
    end
  
    def in_place_edit_deadline
      if @project.deadline.present?
        render :json => { 
            :due_date => @project.lesite_due_date, 
            :deadline => @project.deadline.strftime("%b %d")
            }
      else
        render :text => "Click to edit"
      end
    end
    
end