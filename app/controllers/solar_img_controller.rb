class SolarImgController < ApplicationController
  def index
    daysToDisplay = 7
    numRecords = daysToDisplay * $all_mtus.length
    dayHistsResult = DayHist.limit(numRecords).order( "day DESC" )
    
    if (dayHistsResult.length < numRecords)
      numRecords = dayHistsResult.length
      daysToDisplay = numRecords / 3
    end
    
    pgeWatts = Array.new( daysToDisplay )
    solarWatts = Array.new( daysToDisplay )
    netWatts = Array.new( daysToDisplay )
    dayLabel = Array.new( daysToDisplay )
    
    # Since we're reverse ordered, we actually do the strings backward for the graph
    dayIdx = daysToDisplay - 1
    recIdx = 0
    dayHistsResult.each do |dayHist|
      if (dayHist.mtu == $pge_mtu) then
        pgeWatts[dayIdx] = (dayHist.watts / 1000)
      elsif (dayHist.mtu == $solar_mtu) then
        solarWatts[dayIdx] = (dayHist.watts / 1000)
      end
      dayLabel[dayIdx] = "#{dayHist.day.month}/#{dayHist.day.day}"
      recIdx = recIdx + 1
      if (recIdx == $all_mtus.length) then
        dayIdx = dayIdx - 1
        recIdx = 0
      end
    end
    
    dayIdx = 0
    while (dayIdx < daysToDisplay) do
      netWatts[dayIdx] = (pgeWatts[dayIdx] + solarWatts[dayIdx]).to_s
      pgeWatts[dayIdx] = pgeWatts[dayIdx].to_s
      solarWatts[dayIdx] = solarWatts[dayIdx].to_s
      dayIdx = dayIdx + 1
    end
    logger.debug "pgeWatts=#{pgeWatts}, solarWatts=#{solarWatts}, netWatts=#{netWatts}"
    
    # https://developers.google.com/chart/image/docs/gallery/bar_charts
      
      @liveGraphURL =
        "http://chart.googleapis.com/chart" +
           "\?chxl=0:|-10|0|10|20|30|40|1:|#{dayLabel.join('|')}" + 
           "\&chxr=0,-10,40|1,1,100" +
           "\&chxs=0,676767,11.5,0,l,676767" + 
           "\&chco=008000,FF0000,666666" + 
           "\&chxt=y,x" +
           "\&chbh=a,1,12" +
           "\&chs=300x225" +
           "\&cht=bvg" +
           "\&chds=-10,40,-10,40,-10,40" +
           "\&chd=t:#{solarWatts.join(',')}|#{pgeWatts.join(',')}|#{netWatts.join(',')}"
          
           
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @ted_data }
      end
  end
end
