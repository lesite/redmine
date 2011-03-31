require_dependency 'version'

module RedmineLesiteBulkAdjustVersionDeadlinesVersionPatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_update :adjust_all_subsequent_versions
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods

    def adjust_all_subsequent_versions
      return if effective_date.blank?
      adjust = VersionCustomField.find_by_name("Adjust All Subsequent Versions")
      if adjust.present?
        c = custom_field_values.select{ |v| v.custom_field_id == adjust.id }
        do_adjust = c[0].value if c.present?
      end
      if do_adjust && do_adjust == "1"
        subsequent_versions = Version.find(:all, :conditions => "project_id = #{project_id} AND (effective_date > str_to_date('#{effective_date_was}','%Y-%m-%d') OR effective_date IS NULL) AND id != #{id}",:order=>"effective_date asc, name asc")
        last_effective_date = effective_date
        iteration_length_field = ProjectCustomField.find_by_name("Iteration Length In Days")  
        c = project.custom_field_values.select{ |v| v.custom_field_id == iteration_length_field.id }
        iteration_length = c[0].value.to_i if c.present?

        subsequent_versions.each do |v|
          new_effective_date = last_effective_date + iteration_length.days
          date_string = new_effective_date.to_s(:db)
          v.connection.execute("UPDATE versions SET effective_date = '#{date_string}'  WHERE id = #{v.id}")
          last_effective_date = new_effective_date
        end 
      end  
    end
    
  end    
end

Version.send(:include, RedmineLesiteBulkAdjustVersionDeadlinesVersionPatch)


