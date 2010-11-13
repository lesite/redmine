class Boilerplate < ActiveRecord::Base
  unloadable
  belongs_to :tracker
  validates_presence_of :content, :tracker
  validates_uniqueness_of :tracker_id
  
  def self.content tracker_id
    b = Boilerplate.find_by_tracker_id(tracker_id)
    if b.present?
      b.content
    else
      ""
    end
  end
  
  def self.trackers_that_need_boilerplate
    Tracker.find(:all, :select => "trackers.id, trackers.name", :joins => "LEFT JOIN boilerplates ON trackers.id = boilerplates.tracker_id WHERE boilerplates.id IS NULL")
  end
  
end