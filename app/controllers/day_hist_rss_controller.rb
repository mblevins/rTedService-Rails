class DayHistRssController < ApplicationController
  def index
      dayPowersResult = DayPower.limit(7).order( "day DESC" )
      @daysToDisplay = dayPowersResult.length
      
      @descriptions = Array.new( @daysToDisplay )
      @dayLabel = Array.new( @daysToDisplay )
      @guids = Array.new( @daysToDisplay )
      @rfc822Label = Array.new( @daysToDisplay )
      @rssUrl = day_powers_url

      # Since we're reverse ordered, we actually do the strings backward for the graph
      dayIdx = @daysToDisplay - 1
      recIdx = 0

      # Since we're reverse ordered, we actually do the strings backward for the graph
      dayIdx = 0
      dayPowersResult.each do |dp|
        
        @dayLabel[dayIdx] = "#{dp.day.month}/#{dp.day.day}/#{dp.day.year}"
        @rfc822Label[dayIdx] = dp.day.rfc2822
        @guids[dayIdx] = day_power_url( dp.id )
        
        @descriptions[dayIdx] = "\n" +
           "<ul>\n" + 
           "<li>Net Power Used (PGE + Solar): #{dp.solarWatts + dp.pgeWatts} kWh\n" +
           "<li>PGE delivered: #{dp.pgeWatts} kWh\n" +
           "<li>Solar generated: #{dp.solarWatts} kWh\n" +
           "<li>Water used: ~ #{dp.waterWatts} kWh\n" +
           "</ul>"

        dayIdx = dayIdx + 1
      end

    render :template => 'day_hist_rss/index.xml.erb'
    end
end
