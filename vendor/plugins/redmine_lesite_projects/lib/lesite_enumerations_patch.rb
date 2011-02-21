require_dependency 'enumeration'

module LesiteEnumerationsPatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      require_dependency 'phase'
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
  end    
end

Enumeration.send(:include, LesiteEnumerationsPatch)


