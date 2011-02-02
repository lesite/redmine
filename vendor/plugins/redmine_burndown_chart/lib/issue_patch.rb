require_dependency 'issue'

module IssuePatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      before_save :log_closed_issues_for_burndown
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    
    def log_closed_issues_for_burndown
      if closing?
        puts "CLOSING"
        logger.info "CLOSING THIS ISSUE"
        self.closed_at = Time.now 
      else
        puts "NOT CLOSING"
        logger.info "NOT CLOSING THE ISSUE"
      end
    end
    
  end    
end

Issue.send(:include, IssuePatch)