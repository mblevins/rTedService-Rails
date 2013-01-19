class DayHistRssController < ApplicationController
  def index
      # This is way replicated code with the charts - need to combine them
      @daysToDisplay = 7
      numRecords = @daysToDisplay * $all_mtus.length
      dayHistsResult = DayHist.limit(numRecords).order( "day DESC" )

      if (dayHistsResult.length < numRecords)
        numRecords = dayHistsResult.length
        @daysToDisplay = numRecords / 3
      end

      pgeWatts = Array.new( @daysToDisplay )
      solarWatts = Array.new( @daysToDisplay )
      netWatts = Array.new( @daysToDisplay )
      waterWatts = Array.new( @daysToDisplay )
      @descriptions = Array.new( @daysToDisplay )
      @dayLabel = Array.new( @daysToDisplay )
      @rfc822Label = Array.new( @daysToDisplay )

      # Since we're reverse ordered, we actually do the strings backward for the graph
      dayIdx = @daysToDisplay - 1
      recIdx = 0

      # Since we're reverse ordered, we actually do the strings backward for the graph
      dayIdx = @daysToDisplay - 1
      recIdx = 0
      dayHistsResult.each do |dayHist|
        if (dayHist.mtu == $pge_mtu) then
          pgeWatts[dayIdx] = (dayHist.watts / 1000)
        elsif (dayHist.mtu == $solar_mtu) then
          solarWatts[dayIdx] = (dayHist.watts / 1000)
        elsif (dayHist.mtu == $water_mtu) then
            waterWatts[dayIdx] = (dayHist.watts / 1000).to_s
        end
        @dayLabel[dayIdx] = "#{dayHist.day.month}/#{dayHist.day.day}/#{dayHist.day.year}"
        @rfc822Label[dayIdx] = dayHist.day.rfc2822
        recIdx = recIdx + 1
        if (recIdx == $all_mtus.length) then
          dayIdx = dayIdx - 1
          recIdx = 0
        end
      end

      # This is pretty bad, but we'll keep it in the same format as the graphs so we can merge later
      dayIdx = 0
      while (dayIdx < @daysToDisplay) do
        netWatts[dayIdx] = (pgeWatts[dayIdx] + solarWatts[dayIdx]).to_s
        pgeWatts[dayIdx] = pgeWatts[dayIdx].to_s
        solarWatts[dayIdx] = solarWatts[dayIdx].to_s
        waterWatts[dayIdx] = waterWatts[dayIdx].to_s
        @descriptions[dayIdx] = "\n" +
          "<ul>\n" + 
          "<li>Net Power Used (PGE + Solar): #{netWatts[dayIdx]} kWh\n" +
          "<li>PGE delivered: #{pgeWatts[dayIdx]} kWh\n" +
          "<li>Solar generated: #{solarWatts[dayIdx]} kWh\n" +
          "<li>Water used: ~ #{waterWatts[dayIdx]} kWh\n" +
          "</ul>"
        dayIdx = dayIdx + 1
      end

       # todo: better way of doing this. Same problem as the ted activation pages
       render :template => 'day_hist_rss/index.xml.erb'
    end
end
