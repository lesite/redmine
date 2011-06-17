require_dependency 'time_entry_activity'
module LesiteProjectsTimeEntryActivityPatch
  
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      unloadable
    end
  end
  
  module ClassMethods
    
    def projects_table 
      find(:all, :select => "id, name", :group => "name")
    end
  end
  
end

TimeEntryActivity.send(:include, LesiteProjectsTimeEntryActivityPatch)