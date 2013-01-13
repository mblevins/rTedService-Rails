class SolarImgController < ApplicationController
  def index
    daysToDisplay = 3
    dayHistsResult = DayHist.limit(daysToDisplay * $all_mtus.length).order( "day DESC" )
    
    pgeWatts = Array.new( daysToDisplay )
    solarWatts = Array.new( daysToDisplay )
    
    # Since we're reverse ordered, we actually do the strings backward for the graph
    dayIdx = daysToDisplay - 1
    recIdx = 0
    dayHistsResult.each do |dayHist|
      if (dayHist.mtu == $pge_mtu) then
        pgeWatts[dayIdx] = (dayHist.watts / 1000).to_s
      elsif (dayHist.mtu == $solar_mtu) then
        solarWatts[dayIdx] = (dayHist.watts / 1000).to_s
      end
      recIdx = recIdx + 1
      if (recIdx == $all_mtus.length) then
        dayIdx = dayIdx - 1
        recIdx = 0
      end
    end
    
    @liveGraphURL =
      "http://chart.googleapis.com/chart?chxr=0,1.667,95\&chxs=0,676767,11.5,0,l,676767" +
      "\&chxt=y\&chbh=a,2,12\&chs=480x319\&cht=bvg\&chco=A2C180,FF0000\&chds=-10,40,-10,40" + 
      "\&chd=t:#{solarWatts.join(',')}|#{pgeWatts.join(',')}\&chma=|2" +
      "\&chtt=Solar+%26+Power+Meter\&chts=676767,12.5"
      
      logger.debug "url=#{@liveGraphURL}"

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @ted_data }
      end
  end
end
