require_dependency 'project'

module LesiteProjectsProjectPatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    
    def deadline_passed?
      deadline.present? && (deadline < Date.today)
    end
    
  end    
end

Project.send(:include, LesiteProjectsProjectPatch)

