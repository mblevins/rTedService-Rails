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
    dayLabel = Array.new( daysToDisplay )
    
    # Since we're reverse ordered, we actually do the strings backward for the graph
    dayIdx = daysToDisplay - 1
    recIdx = 0
    dayHistsResult.each do |dayHist|
      if (dayHist.mtu == $pge_mtu) then
        pgeWatts[dayIdx] = (dayHist.watts / 1000).to_s
      elsif (dayHist.mtu == $solar_mtu) then
        solarWatts[dayIdx] = (dayHist.watts / 1000).to_s
      end
      dayLabel[dayIdx] = "#{dayHist.day.month}/#{dayHist.day.day}"
      recIdx = recIdx + 1
      if (recIdx == $all_mtus.length) then
        dayIdx = dayIdx - 1
        recIdx = 0
      end
    end
    
    # https://developers.google.com/chart/image/docs/gallery/bar_charts
      
      @liveGraphURL =
        "http://chart.googleapis.com/chart" +
           "\?chxl=0:|-10|0|10|20|30|40|1:|#{dayLabel.join('|')}" + 
           "\&chxr=0,-10,40|1,1,100" +
           "\&chxs=0,676767,11.5,0,l,676767" + 
           "\&chco=008000,FF0000" + 
           "\&chxt=y,x" +
           "\&chbh=a,2,12" +
           "\&chs=300x225" +
           "\&cht=bvg" +
           "\&chco=A2C180,3D7930" +
           "\&chds=-10,40,-10,40" +
           "\&chd=t:#{solarWatts.join(',')}|#{pgeWatts.join(',')}" +
           "\&chtt=Solar+%26+Power+Meter" 
          
           
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @ted_data }
      end
  end
end
