class Burndown
  
  def self.chart args = { :width => 800, :height => 300, :title => "Burndown", :x_data => [40,36,32,28,24,20,16,12,8,4,0], :y_data => [40,39,38,37,36,35,30,25,23,21,18,14,12,9,1], :grid => [6,6,1,1,6,6], :margins => [30,30,30,30], :visible_axes => ["x","y"], :colors => ["FF0000","00FF00"], :x_range => [0,0,30,2], :y_range => [1,0,40,2], :min_max => [0,40] }

    args.each_pair {|k,v| args[k] = v.join(",") if v.is_a?(Array) }

    %{<img src='http://chart.apis.google.com/chart?chs=#{args[:width]}x#{args[:height]}&chtt=#{args[:title]}&cht=lc&chdl=estimated|actual&chco=#{args[:colors]}&chxr=#{args[:x_range]}|#{args[:y_range]}&chds=#{args[:min_max]}&chd=t:#{args[:x_data]}|#{args[:y_data]}&chg=#{args[:grid]}&chma=#{args[:margins]}&chxt=#{args[:visible_axes]}
    '/>}
    
  end
  
  
end