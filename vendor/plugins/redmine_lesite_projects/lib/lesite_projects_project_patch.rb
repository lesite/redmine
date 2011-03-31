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
    
    def coordinator_maintainer
      maintainer_role = Role.find_by_name("Maintainer", :select => "id")
      coordinator_role = Role.find_by_name("Coordinator", :select => "id")
      maintainer = members.find(:first,
        :conditions => "member_roles.role_id=#{maintainer_role.id} ",
        :select => "concat_ws(users.first_name,users.last_name,'')") if maintainer_role.present?
      coordinator = members.find(:first,
        :conditions => "member_roles.role_id=#{coordinator_role.id}",
        :select => "concat_ws(users.first_name,users.last_name,'')") if coordinator_role.present?
      coordinator_name = coordinator.present? ? coordinator.name : "N/A"
      maintainer_name = coordinator.present? ? coordinator.name : "N/A"
      ["#{coordinator_name} (C)", "#{maintainer_name} (M)"].join(", ")
    end
    
  end    
end

Project.send(:include, LesiteProjectsProjectPatch)

