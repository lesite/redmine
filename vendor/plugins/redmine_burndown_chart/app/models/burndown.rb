class Burndown
  
  def self.chart args

    args = Burndown::DEFAULTS.merge(args)
    
    args.each_pair {|k,v| args[k] = v.join(",") if v.is_a?(Array) }

    %{<br />
      <div>
        <label for="burndown_range"></label>
        <select id="burndown_range">
          <option value="last_week">Last Week</option>
          <option value="last_two_weeks">Last Two Weeks</option>
          <option value="last_month">Last Month</option>
        </select>
      </div>
      <div style="float:left;height:150px;padding-top:150px">Open<br/>Issues</div>
      <img src='http://chart.apis.google.com/chart?&chxl=100:|Open+Issues&chs=#{args[:width]}x#{args[:height]}&chtt=#{args[:title]}&cht=lc&chdl=ideal|actual&chco=#{args[:colors]}&chxr=#{args[:x_range]}|#{args[:y_range]}&chds=#{args[:min_max]}&chd=t:#{args[:x_data]}|#{args[:y_data]}&chg=#{args[:grid]}&chma=#{args[:margins]}&chxt=#{args[:visible_axes]}
    '/>  <div style="clear:both;width:800px;text-align:center">Days</div>
    }
    
  end
  
  
  DEFAULTS = {
      :width => 800, 
      :height => 300, 
      :title => "Burndown", 
      :x_data => [40,36,32,28,24,20,16,12,8,4,0], 
      :y_data => [40,36,32,28,24,20,16,12,8,4,0], 
      :grid => [6,6,1,1,6,6], 
      :margins => [30,30,30,30], 
      :visible_axes => ["x","y"], 
      :colors => ["FF0000","00FF00"], 
      :x_range => [0,0,30,2], 
      :y_range => [1,0,40,2], 
      :min_max => [0,40] 
    }
  
end