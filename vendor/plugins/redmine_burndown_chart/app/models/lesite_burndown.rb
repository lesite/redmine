class LesiteBurndown
  set_table_name "burndowns"
  
  DEFAULTS = {
      :width => 650, 
      :height => 300, 
      :title => "Burndown", 
      :margins => [30,30,30,30], 
      :visible_axes => ["x","y"], 
      :colors => ["FF0000","008E00","0000FF"], 
      :x_range => [0,0,30], 
      :y_range => [1,0,40,2], 
      :min_max => [0,40] 
    }
  
  def self.chart project, days
    total = project.issues.count
    args = LesiteBurndown::DEFAULTS.merge({
  	  :remaining => IssueBurndownLog.issues_remaining_in_last_thirty_days(project.id,days),
  	  :completed => IssueBurndownLog.issues_closed_in_last_thirty_days(project.id,days), 
      :y_range => [1, 0, total, (total.to_f / 15.to_f).ceil],
      :ideal => get_ideal(total,days),
      :min_max => [0,total],
      :x_range => [0, 0, days, days == 30 ? 2 : 1]
    })
    args.each_pair {|k,v| args[k] = v.join(",") if v.is_a?(Array) }   
    %{http://chart.apis.google.com/chart?chxt=y&chbh=a&cht=bvo&chco=#{args[:colors]}&chd=t1:#{args[:completed]}|#{args[:remaining]}|#{args[:ideal]}&chxr=#{args[:x_range]}|#{args[:y_range]}&chs=#{args[:width]}x#{args[:height]}&chdl=completed|actual|ideal&chds=#{args[:min_max]}&chma=#{args[:margins]}&chxt=#{args[:visible_axes]}&chm=D,008E00,1,0,1,1|D,0000FF,2,0:29,1,1}
  end
  
  def self.get_ideal(total,days)
    ideal_step = total.to_f / (days -1).to_f
    ideal = []
    current = total.to_f
    (days).times do 
      ideal << current
      current = current - ideal_step
    end
    return ideal
  end
  
  
end